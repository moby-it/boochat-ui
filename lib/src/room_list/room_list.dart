import 'package:boochat_ui/src/common/route_provider.dart';
import 'package:boochat_ui/src/create_room/create_room.dart';
import 'package:boochat_ui/src/room_list/bloc/room_list_bloc.dart';
import 'package:boochat_ui/src/room_list/bloc/room_list_state.dart';
import 'package:boochat_ui/src/room_list/room_slot.dart';
import 'package:boochat_ui/src/routes/route_names.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/data.dart';
import '../layout_widgets/bottom_navigation.dart';

class RoomListWrapper extends StatelessWidget {
  const RoomListWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        context
                            .read<RouteState>()
                            .setActiveRoute(RouteNames.createRoom, 0);
                        Navigator.pushNamed(context, CreateRoom.routeName);
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
          return RoomList(rooms: state.rooms);
        } else {
          return const Text('No rooms');
        }
      }),
      bottomNavigationBar: !kIsWeb ? const BottomNavigation() : null,
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
