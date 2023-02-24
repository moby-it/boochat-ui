import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/room_list_bloc.dart';
import '../bloc/room_list_state.dart';
import '../room_list.dart';
import 'create_room_button.dart';
import 'search_room_input.dart';

class WebRoomList extends StatelessWidget {
  const WebRoomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: BlocBuilder<RoomListBloc, RoomListState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
            GestureDetector(
              onTap: () {
                debugPrint("create room");
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    SearchRoomInput(),
                    CreateRoomButton()
                  ],
                ),
              ),
            ),
            if (state.rooms.isNotEmpty)
              Expanded(child: RoomList(rooms: state.rooms)),
            if (state.rooms.isEmpty)
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Text(
                    "You have no Rooms!",
                    style: Theme.of(context).textTheme.labelMedium,
                  ))
          ]),
        );
      }),
    );
  }
}
