import 'package:boochat_ui/room-list/mock_rooms.dart';
import 'package:boochat_ui/room-list/room.dart';
import 'package:flutter/widgets.dart';

class RoomList extends StatefulWidget {
  const RoomList({Key? key}) : super(key: key);

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  final rooms =
      mockRooms.map((dynamic jsonRoom) => Room.fromJson(jsonRoom)).toList();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var room = rooms[index];
        return RoomSlot(room: room);
      },
      itemCount: mockRooms.length,
    );
  }
}

class RoomSlot extends StatelessWidget {
  const RoomSlot({required this.room, Key? key}) : super(key: key);
  final Room room;
  @override
  Widget build(BuildContext context) {
    return Text(room.name);
  }
}
