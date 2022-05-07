import 'package:boochat_ui/src/shared/auth_bloc/auth_state.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class Login extends AuthEvent {}
