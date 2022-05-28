import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../create_room/create_room.dart';
import 'bloc/room_list_bloc.dart';
import 'bloc/room_list_state.dart';
import 'room_list.dart';
import 'search_room.dart';

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
                  child: GestureDetector(
                    onTap: () {
                      debugPrint("create room");
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SearchRoom(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.add_to_photos_outlined),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Create Room")
                                ]),
                          )
                        ],
                      ),
                    ),
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
