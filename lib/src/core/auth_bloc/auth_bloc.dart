import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data.dart';
import '../core.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthState()) {
    on<Login>(_onLogin);
  }

  void _onLogin(Login event, Emitter<AuthState> emit) async {
    final response = await _authRepository.login();
    if (response.hasSucceded) {
      emit(AuthState.authenticated(response.user, response.token));
    } else {
      emit(const AuthState.unauthenicated());
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
