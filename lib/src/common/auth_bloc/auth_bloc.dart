import 'package:boochat_ui/src/common/auth_bloc/auth_events.dart';
import 'package:boochat_ui/src/data/auth_repository.dart';
import 'package:boochat_ui/src/common/auth_bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthState()) {
    on<Login>(_onLogin);
  }

  void _onLogin(Login event, Emitter<AuthState> emit) async {
    final response = await _authRepository.login();
    emit(AuthState.authenticated(response.user, response.token));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
