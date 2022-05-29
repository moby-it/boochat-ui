import 'package:boochat_ui/src/active_room/bloc/active_room_bloc.dart';
import 'package:boochat_ui/src/active_room/bloc/active_room_events.dart';
import 'package:boochat_ui/src/active_room/bloc/active_room_state.dart';
import 'package:boochat_ui/src/active_room/date_seperator.dart';
import 'package:boochat_ui/src/active_room/empty_room.dart';
import 'package:boochat_ui/src/active_room/message_input.dart';
import 'package:boochat_ui/src/active_room/room_item_bubble.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../common/common.dart';
import '../../data/data.dart';

class WebActiveRoom extends StatelessWidget {
  final String roomId;
  WebActiveRoom({required this.roomId, Key? key}) : super(key: key);
  final queryUri = dotenv.env["QUERY_URI"];

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().state.user;
    final allUsers = context.read<UsersBloc>().state.allUsers;
    final roomRepository = context.read<RoomRepository>();
    final activeRoomBloc = context.read<ActiveRoomBloc>();
    final token = context.read<AuthBloc>().state.token;
    if (queryUri == null) {
      throw Exception("cannot fetch room with no query uri");
    }
    activeRoomBloc.add(const FetchingActiveRoomEvent());
    return FutureBuilder(
      future: roomRepository.fetchRoom(roomId, token),
      builder: (context, AsyncSnapshot<Room> snapshot) {
        if (snapshot.hasData && !snapshot.hasError) {
          activeRoomBloc.add(SelectActiveRoomEvent(snapshot.data!));
        }
        return BlocBuilder<ActiveRoomBloc, ActiveRoomState>(
          builder: (context, state) {
            if (state is NoActiveRoomSelectedState) {
              return const Center(child: EmptyRoom());
            } else if (state is FetchingActiveRoomState) {
              return const Scaffold(body: Text("fetching room details..."));
            } else {
              final room = (state as ActiveRoomSelectedState).room;
              final items = room.items.reversed.toList();
              return Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        color: Theme.of(context).cardColor,
                        height: 60,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.only(left: 24),
                            child: Text(
                                Room.configureRoomName(user, allUsers, room),
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.left),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: ListView.separated(
                                reverse: true,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 8,
                                    ),
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  final roomItem = items[index];
                                  // Previous item is index + 1 due to the array being reversed
                                  bool showUserImage = true;
                                  bool showDateSeperator = false;
                                  if (roomItem is Message &&
                                      index + 1 < items.length) {
                                    final previousItem = items[index + 1];
                                    if (previousItem is Message &&
                                        previousItem.sender ==
                                            roomItem.sender) {
                                      showUserImage = false;
                                    }
                                    if (previousItem.dateSent.day !=
                                        roomItem.dateSent.day) {
                                      showDateSeperator = true;
                                      showUserImage = true;
                                    }
                                  }
                                  if (showDateSeperator) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        DateSeperator(date: roomItem.dateSent),
                                        RoomItemBubble(
                                          roomItem: items[index],
                                          showUserImage: showUserImage,
                                        )
                                      ],
                                    );
                                  } else {
                                    return RoomItemBubble(
                                      roomItem: items[index],
                                      showUserImage: showUserImage,
                                    );
                                  }
                                }),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const MessageInput()
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}