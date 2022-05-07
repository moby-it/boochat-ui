export './command_socket_manager.dart';
export './query_socket_manager.dart';
export './websocket_events.dart';
import '../data.dart';

class SocketEvent<T> {
  SocketEvent({required this.name, required this.jsonData});
  final String name;
  T jsonData;
  isRoomListEvent() {
    return name == WebsocketEvents.newRoomItem ||
        name == WebsocketEvents.roomList;
  }
}
