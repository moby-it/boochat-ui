import 'package:boochat_ui/src/room_list/room_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../create_room/create_room.dart';
import '../bloc/room_list_bloc.dart';
import '../bloc/room_list_state.dart';

class MobileRoomList extends StatelessWidget {
  const MobileRoomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
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
      ),
      body: BlocBuilder<RoomListBloc, RoomListState>(builder: (context, state) {
        if (state.hasData) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: RoomList(rooms: state.rooms),
          );
        } else {
          return const Text('No rooms');
        }
      }),
    );
  }
}
