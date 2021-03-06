import 'package:boochat_ui/src/active_room/bloc/active_room_bloc.dart';
import 'package:boochat_ui/src/active_room/bloc/active_room_state.dart';
import 'package:boochat_ui/src/core/core.dart';
import 'package:boochat_ui/src/core/widgets/hover.dart';
import 'package:boochat_ui/src/data/data.dart';
import 'package:boochat_ui/src/room_list/bloc/room_list_bloc.dart';
import 'package:boochat_ui/src/room_list/bloc/room_list_events.dart';
import 'package:boochat_ui/src/room_list/last_room_item.dart';
import 'package:boochat_ui/src/room_list/online_dot.dart';
import 'package:boochat_ui/src/routes/route_names.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
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
    return Hover(
      color: Theme.of(context).hoverColor,
      child: InkWell(
        hoverColor: Colors.transparent,
        mouseCursor: SystemMouseCursors.click,
        onTap: () {
          final activeRoomState = context.read<ActiveRoomBloc>().state;
          bool shouldNavigate = !(activeRoomState is ActiveRoomSelectedState &&
              activeRoomState.room.id == room.id);
          if (shouldNavigate) {
            final rooms = context.read<RoomListBloc>().state.rooms;
            rooms.firstWhere((element) => element == room).hasUnreadMessage =
                false;
            context.read<RoomListBloc>().add(UpdateRoomListEvent(rooms));
            kIsWeb
                ? context.goNamed(RouteNames.room, params: {'id': room.id})
                : context.pushNamed(RouteNames.room, params: {'id': room.id});
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
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
                              Room.configureRoomImageUrl(user, allUsers, room),
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
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                            )),
                    if (room.items.isNotEmpty)
                      LastRoomItem(
                        hasUnreadMessage: room.hasUnreadMessage,
                        roomItem: room.items.last,
                      )
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
      ),
    );
  }
}
