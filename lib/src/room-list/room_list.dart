import 'package:boochat_ui/src/data/room.dart';
import 'package:boochat_ui/src/room-list/room_slot.dart';
import 'package:flutter/material.dart';

import '../data/data.dart';

class RoomListWrapper extends StatelessWidget {
  const RoomListWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Boochat")),
      body: StreamBuilder(
          stream: const Stream.empty(),
          builder: (context, snapshot) {
            return const Text("some rooms");
            // if (snapshot.hasData) {
            //   final rooms =
            //       snapshot.data!.jsonData.map((e) => Room.fromJson(e)).toList();
            //   return RoomList(rooms: rooms);
            // } else {
            //   return const Text('rooms loading');
            // }
          }),
    );
  }
}

class RoomList extends StatelessWidget {
  const RoomList({required this.rooms, Key? key}) : super(key: key);
  final List<Room> rooms;
  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) => RoomSlot(room: rooms[index]));
}
