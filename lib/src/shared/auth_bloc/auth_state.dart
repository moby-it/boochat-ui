import 'package:boochat_ui/src/data/data.dart';
import 'package:equatable/equatable.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, authenticating }

class AuthState extends Equatable {
  const AuthState(
      {this.status = AuthStatus.unknown,
      this.user = const User.empty(),
      this.token = ''});

  const AuthState.authenticated(this.user, this.token)
      : status = AuthStatus.authenticated;

  const AuthState.unauthenicated()
      : status = AuthStatus.unauthenticated,
        user = const User.empty(),
        token = '';

  final AuthStatus status;
  final User user;
  final String token;
  @override
  List<Object> get props => [status, user, token];
}
