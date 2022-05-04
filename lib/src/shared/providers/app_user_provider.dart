import 'package:boochat_ui/src/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class AppUserModel extends ChangeNotifier {
  final commandUri = dotenv.env['COMMAND_URI'];
  UserModel? _currentUser;
  late String? _token;
  bool get isLoggedIn => _currentUser != null;
  get token => _token;
  void _setCurrentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> login(UserModel user) async {
    final commandUri = this.commandUri;
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
}

class AuthResponse {
  late String token;
  late UserModel user;
  AuthResponse.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = UserModel.fromJson(json['user']);
}
