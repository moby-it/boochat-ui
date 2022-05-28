import 'package:boochat_ui/src/create_room/create_room.dart';
import 'package:boochat_ui/src/room_list/bloc/room_list_bloc.dart';
import 'package:boochat_ui/src/room_list/bloc/room_list_state.dart';
import 'package:boochat_ui/src/room_list/room_slot.dart';
import 'package:boochat_ui/src/room_list/search_room.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../data/data.dart';

class RoomListWrapper extends StatelessWidget {
  const RoomListWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: !kIsWeb
          ? AppBar(
              title: const Text("Rooms"),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: BoxShape.circle),
                    child: GestureDetector(
                      onTap: () async {
                        context.pushNamed(CreateRoom.routeName);
                      },
                      child: const Icon(Icons.create),
                    ),
                  ),
                )
              ],
            )
          : null,
      body: BlocBuilder<RoomListBloc, RoomListState>(builder: (context, state) {
        if (state.hasData) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Rooms",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SearchRoom(),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.add_to_photos_outlined),
                            Text("Create Room")
                          ])
                    ],
                  ),
                ),
                Expanded(child: RoomList(rooms: state.rooms))
              ]);
        } else {
          return const Text('No rooms');
        }
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
