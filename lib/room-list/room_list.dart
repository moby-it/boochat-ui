import 'package:boochat_ui/shared/room_model.dart';
import 'package:boochat_ui/room-list/room_slot.dart';
import 'package:flutter/widgets.dart';

class RoomList extends StatelessWidget {
  const RoomList({required this.rooms, Key? key}) : super(key: key);
  final List<RoomModel> rooms;
  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) => RoomSlot(room: rooms[index]));
}
