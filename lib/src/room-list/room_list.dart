import 'package:boochat_ui/src/shared.dart';
import 'package:boochat_ui/src/room-list/room_slot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomListWrapper extends StatelessWidget {
  const RoomListWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<SocketManager>(builder: (context, socketManager, child) {
      if (socketManager.initialized) {
        return StreamBuilder(
            stream: socketManager.queryStream
                .where((event) => event.name == "ROOM_LIST"),
            builder: (context, AsyncSnapshot<SocketEvent> snapshot) {
              if (snapshot.hasData) {
                final rooms = snapshot.data!.jsonData
                    .map((e) => RoomModel.fromJson(e))
                    .toList();
                return RoomList(rooms: rooms);
              } else {
                return const Text('rooms loading');
              }
            });
      } else {
        return const Text('...socket manager initialing');
      }
    });
  }
}

class RoomList extends StatelessWidget {
  const RoomList({required this.rooms, Key? key}) : super(key: key);
  final List<RoomModel> rooms;
  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) => RoomSlot(room: rooms[index]));
}
