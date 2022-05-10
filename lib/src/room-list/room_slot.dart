import 'package:boochat_ui/src/active-room/active_room.dart';
import 'package:boochat_ui/src/common/auth_bloc/auth_bloc.dart';
import 'package:boochat_ui/src/common/auth_bloc/auth_state.dart';
import 'package:boochat_ui/src/data/room.dart';
import 'package:boochat_ui/src/data/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomSlot extends StatelessWidget {
  const RoomSlot({required this.room, Key? key}) : super(key: key);
  final Room room;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, ActiveRoom.routeName, arguments: room),
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
                BlocSelector<AuthBloc, AuthState, User>(
                  selector: (state) => state.user,
                  builder: (context, user) => CachedNetworkImage(
                    imageUrl: room.imageUrl,
                    height: 50,
                    width: 50,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(room.name,
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

  String _configureRoomImage(User user) {
    throw Exception("Not implemented");
    // if (room.participants.length > 2) return room.imageUrl;
    // final otherUser =
    //     room.participants.firstWhere((user) => user.id != user.id);

    // return otherUserImage;
  }
}
