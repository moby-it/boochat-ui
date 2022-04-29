import 'package:boochat_ui/shared/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class UserModel extends ChangeNotifier {
  final commandUri = dotenv.env['COMMAND_URI'];
  late User? _currentUser;
  late String? _token;
  bool get isLoggedIn => _currentUser != null;
  void _setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> login(User user) async {
    final commandUri = this.commandUri;
    if (commandUri == null) throw NullThrownError();
    final response =
        await http.post(Uri.parse('$commandUri/auth'), body: user.toJson());
    if (response.statusCode == 201) {
      final authResponse = AuthResponse.fromJson(json.decode(response.body));
      _token = authResponse.token;
      _setCurrentUser(authResponse.user);
      notifyListeners();
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
