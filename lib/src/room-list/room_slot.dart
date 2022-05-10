import 'package:boochat_ui/src/active-room/active_room.dart';
import 'package:boochat_ui/src/common/common.dart';
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
    final user = context.read<AuthBloc>().state.user;
    final allUsers = context.read<UsersBloc>().state.allUsers;
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
                CachedNetworkImage(
                  imageUrl: _configureRoomImageUrl(user, allUsers),
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_configureRoomName(user, allUsers),
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

  String _configureRoomImageUrl(User user, List<User> allUsers) {
    if (room.participants.length > 2) return room.imageUrl;
    final otherUserId = room.participants.firstWhere((u) => u.id != user.id).id;
    final otherUser = allUsers.firstWhere((user) => user.id == otherUserId);
    return otherUser.imageUrl ?? room.imageUrl;
  }

  String _configureRoomName(User user, List<User> allUsers) {
    if (room.participants.length > 2) return room.imageUrl;
    final otherUserId = room.participants.firstWhere((u) => u.id != user.id).id;
    final otherUser = allUsers.firstWhere((user) => user.id == otherUserId);
    return otherUser.name ?? room.name;
  }
}
