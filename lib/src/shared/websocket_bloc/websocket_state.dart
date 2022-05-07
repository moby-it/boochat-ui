import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart';

enum WebsocketConnectionState { unknown, disconnected, connected }

abstract class WebsocketState extends Equatable {
  const WebsocketState();
  @override
  List<Object?> get props => [];
}

class WebSocketConnectedState extends WebsocketState {
  final Socket querySocket;
  final Socket commandSocket;
  const WebSocketConnectedState(this.commandSocket, this.querySocket);
  @override
  List<Object?> get props => [querySocket, commandSocket];
}

class WebSocketDisconnectedState extends WebsocketState {
  const WebSocketDisconnectedState();
}

class WebSocketConnectingState extends WebsocketState {
  const WebSocketConnectingState();
}
