import 'package:boochat_ui/src/common/common.dart';
import 'package:boochat_ui/src/data/data.dart';
import 'package:boochat_ui/src/routes/route_names.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
        onTap: () {
          context.pushNamed(RouteNames.room, params: {'id': room.id});
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
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          Room.configureRoomImageUrl(user, allUsers, room),
                        ),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(Room.configureRoomName(user, allUsers, room),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      Text(
                        room.items.isNotEmpty
                            ? room.items.last.content
                            : "Room Just Created!",
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
