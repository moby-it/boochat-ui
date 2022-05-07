import './websocket_events.dart';

class SocketEvent<T> {
  SocketEvent({required this.name, required this.jsonData});
  final String name;
  T jsonData;
  isRoomListEvent() {
    return name == WebsocketEvents.newRoomItem ||
        name == WebsocketEvents.roomList;
  }
}

class SocketManager {}
