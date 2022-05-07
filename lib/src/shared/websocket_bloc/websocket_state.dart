import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart';

enum WebsocketConnectionState { unknown, disconnected, connected }

class WebsocketState extends Equatable {
  final WebsocketConnectionState state;
  final Socket? querySocket;
  final Socket? commandSocket;
  const WebsocketState()
      : state = WebsocketConnectionState.unknown,
        querySocket = null,
        commandSocket = null;
  const WebsocketState.connected(this.commandSocket, this.querySocket)
      : state = WebsocketConnectionState.connected;
  const WebsocketState.disconnected()
      : state = WebsocketConnectionState.disconnected,
        commandSocket = null,
        querySocket = null;
  @override
  List<Object?> get props => [state];
}
