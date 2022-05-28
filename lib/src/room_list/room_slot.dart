import 'package:boochat_ui/src/common/common.dart';
import 'package:boochat_ui/src/data/data.dart';
import 'package:boochat_ui/src/room_list/online_dot.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 19),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) => Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                Room.configureRoomImageUrl(
                                    user, allUsers, room),
                              ),
                            )),
                      ),
                      if (room.participants.length == 2 &&
                          state.userIsOnline(room.getOtherUserId(user.id)))
                        const Positioned(top: -6, right: -6, child: OnlineDot())
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(Room.configureRoomName(user, allUsers, room),
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(
                        room.items.isNotEmpty
                            ? room.items.last.content
                            : "Room Just Created!",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                if (room.lastMessageIsSent(user.id))
                  const Icon(
                    Icons.reply_sharp,
                    color: Color.fromRGBO(176, 201, 231, 1),
                  )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
