import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart';

abstract class WebsocketEvent extends Equatable {
  static const roomCreated = 'ROOM_CREATED';
  static const newRoomItem = 'NEW_ROOM_ITEM';
  static const roomList = 'ROOM_LIST';
  static const allUsers = 'ALL_USERS';
  static const activeUserList = 'ACTIVE_USER_LIST';
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
