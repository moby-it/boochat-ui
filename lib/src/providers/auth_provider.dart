import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import '../data/data.dart';

class AuthProvider extends ChangeNotifier {
  bool get isLoggedIn => _currentUser != null;
  get token => _token;
  get currentUser => _currentUser;

  final _googleSignIn = GoogleSignIn(scopes: [
    'profile',
  ], clientId: dotenv.env['CLIENT_ID']);

  final _commandUri = dotenv.env['COMMAND_URI'];
  User? _currentUser;
  late String? _token;
  void _setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> login() async {
    final user = await _signInWithGoogle();
    if (user == null) throw Exception("failed to log in to Google");
    final commandUri = _commandUri;
    if (commandUri == null) throw NullThrownError();
    final response =
        await http.post(Uri.parse('$commandUri/auth'), body: user.toJson());
    if (response.statusCode == 201) {
      final authResponse = AuthResponse.fromJson(json.decode(response.body));
      _token = authResponse.token;
      _setCurrentUser(authResponse.user);
    } else {
      throw Exception('failed to login');
    }
  }

  void logout() {
    _currentUser = null;
    _token = null;
    notifyListeners();
  }

  Future<User?> _signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signInSilently();
      if (account == null) throw Exception('account not found');
      return User(
          id: account.id,
          imageUrl: account.photoUrl,
          name: account.displayName);
    } catch (error) {
      return null;
    }
  }
}

class AuthResponse {
  late String token;
  late User user;
  AuthResponse.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = User.fromJson(json['user']);
}
