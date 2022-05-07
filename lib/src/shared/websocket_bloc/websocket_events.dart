import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart';

abstract class WebsocketEvent extends Equatable {
  const WebsocketEvent();
  @override
  List<Object> get props => [];
}

class WebsocketsConnectedEvent extends WebsocketEvent {
  final Socket commandSocket;
  final Socket querySocket;
  const WebsocketsConnectedEvent(
      {required this.querySocket, required this.commandSocket});
}
