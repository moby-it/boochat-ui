import 'package:boochat_ui/src/data/data.dart';

class RoomListState {
  final List<Room> rooms;
  const RoomListState() : rooms = const [];
  bool get hasData => rooms.isNotEmpty;
  const RoomListState.update(this.rooms);
}
