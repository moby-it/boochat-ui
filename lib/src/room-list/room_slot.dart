import 'dart:io';

import 'package:boochat_ui/src/active-room/active_room.dart';
import 'package:boochat_ui/src/active-room/bloc/active_room_bloc.dart';
import 'package:boochat_ui/src/active-room/bloc/active_room_events.dart';
import 'package:boochat_ui/src/common/common.dart';
import 'package:boochat_ui/src/data/room.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomSlot extends StatelessWidget {
  const RoomSlot({required this.room, Key? key}) : super(key: key);
  final Room room;
  @override
  Widget build(BuildContext context) {
    final activeRoomBloc = context.read<ActiveRoomBloc>();
    final user = context.read<AuthBloc>().state.user;
    final allUsers = context.read<UsersBloc>().state.allUsers;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () {
          if (!kIsWeb) {
            Navigator.pushNamed(context, ActiveRoom.routeName);
          }
          activeRoomBloc.add(SelectActiveRoomEvent(room));
        },
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
            child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: Room.configureRoomImageUrl(user, allUsers, room),
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(Room.configureRoomName(user, allUsers, room),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white)),
                    Text(room.items.isNotEmpty
                        ? room.items.last.content
                        : "Room Just Created!")
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
