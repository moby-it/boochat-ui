import 'dart:async';

import 'package:boochat_ui/src/shared/auth_bloc/auth_state.dart';
import 'package:boochat_ui/src/shared/websocket_bloc/websocket_events.dart';
import 'package:boochat_ui/src/shared/websocket_bloc/websocket_manager.dart';
import 'package:boochat_ui/src/shared/websocket_bloc/websocket_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_bloc/auth_bloc.dart';

class WebsocketBloc extends Bloc<WebsocketEvent, WebsocketState> {
  final WebsocketManager _websocketManager;
  final AuthBloc _authBloc;
  late final StreamSubscription authBlocSubscription;
  late final StreamSubscription socketsConnectedSubscription;
  WebsocketBloc(this._websocketManager, this._authBloc)
      : super(const WebSocketConnectingState()) {
    on<WebsocketsConnectedEvent>(_onWebsocketsConnected);
    authBlocSubscription = _authBloc.stream.listen((state) {
      if (state.status == AuthStatus.authenticated &&
          _websocketManager.isDisconnected) {
        _websocketManager.connect(state.token);
      }
    });
    socketsConnectedSubscription =
        _websocketManager.socketsConnected$.stream.listen((connected) {
      if (connected) {
        add(WebsocketsConnectedEvent(
            commandSocket: _websocketManager.commandSocket,
            querySocket: _websocketManager.querySocket));
      }
    });
  }
  void _onWebsocketsConnected(
      WebsocketsConnectedEvent event, Emitter<WebsocketState> emit) {
    emit(WebSocketConnectedState(event.commandSocket, event.querySocket));
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    socketsConnectedSubscription.cancel();
    return super.close();
  }
}
