import 'dart:convert' show json;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import './models/models.dart';

class AuthRepository {
  final _googleSignIn = GoogleSignIn(
      scopes: ['profile', 'email'], clientId: dotenv.env['CLIENT_ID']);

  final _commandUri = dotenv.env['COMMAND_URI'];

  Future<AuthResponse> login() async {
    final user = await _signInWithGoogle();
    if (user == null) throw Exception("failed to log in to Google");
    final commandUri = _commandUri;
    if (commandUri == null) throw NullThrownError();
    final response =
        await http.post(Uri.parse('$commandUri/auth'), body: user.toJson());
    if (response.statusCode == 201) {
      final authResponse = AuthResponse.success(json.decode(response.body));
      return authResponse;
    } else {
      return AuthResponse.failed();
    }
  }

  Future<User?> _signInWithGoogle() async {
    try {
      var account = await _googleSignIn.signInSilently();
      account ??= await _googleSignIn.signIn();
      if (account != null) {
      } else {
        throw Exception('account not found');
      }
      return User(
          id: account.id,
          imageUrl: account.photoUrl,
          email: account.email,
          name: account.displayName);
    } catch (error) {
      return null;
    }
  }
}

class AuthResponse {
  late String token;
  late User user;
  late bool hasSucceded;
  AuthResponse.success(Map<String, dynamic> json)
      : token = json['token'],
        user = User.fromJson(json['user']),
        hasSucceded = true;
  AuthResponse.failed()
      : token = '',
        user = const User.empty(),
        hasSucceded = false;
}
