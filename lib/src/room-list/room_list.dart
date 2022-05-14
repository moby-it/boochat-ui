import 'package:boochat_ui/src/data/room.dart';
import 'package:boochat_ui/src/room-list/bloc/room_list_bloc.dart';
import 'package:boochat_ui/src/room-list/bloc/room_list_state.dart';
import 'package:boochat_ui/src/room-list/room_slot.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/data.dart';

class RoomListWrapper extends StatelessWidget {
  const RoomListWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !kIsWeb ? AppBar(title: const Text("Boochat")) : null,
      body: BlocBuilder<RoomListBloc, RoomListState>(builder: (context, state) {
        if (state.hasData) {
          return RoomList(rooms: state.rooms);
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
