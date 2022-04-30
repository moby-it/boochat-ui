import 'package:boochat_ui/room-list/mock_rooms.dart';
import 'package:boochat_ui/room-list/room.dart';
import 'package:flutter/widgets.dart';

class RoomList extends StatelessWidget {
  const RoomList({required this.rooms, Key? key}) : super(key: key);
  final List<Room> rooms;
  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) => Text(rooms[index].name));
}
