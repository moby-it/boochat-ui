import 'package:boochat_ui/src/active_room/bloc/active_room_bloc.dart';
import 'package:boochat_ui/src/active_room/bloc/active_room_events.dart';
import 'package:boochat_ui/src/active_room/bloc/active_room_state.dart';
import 'package:boochat_ui/src/active_room/date_seperator.dart';
import 'package:boochat_ui/src/active_room/message_input.dart';
import 'package:boochat_ui/src/active_room/room_item_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../core/core.dart';
import '../../data/data.dart';

class MobileActiveRoom extends StatelessWidget {
  final String roomId;
  MobileActiveRoom({required this.roomId, Key? key}) : super(key: key);
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
    return FutureBuilder(
      future: roomRepository.fetchRoom(roomId, token),
      builder: (context, AsyncSnapshot<Room> snapshot) {
        if (snapshot.hasData && !snapshot.hasError) {
          activeRoomBloc.add(SelectActiveRoomEvent(snapshot.data!));
        }
        return BlocBuilder<ActiveRoomBloc, ActiveRoomState>(
          builder: (context, state) {
            if (state is FetchingActiveRoomState ||
                state is NoActiveRoomSelectedState) {
              return const Scaffold(body: Text("fetching room details..."));
            } else {
              final room = (state as ActiveRoomSelectedState).room;
              final items = room.items.reversed.toList();
              return Scaffold(
                appBar: AppBar(
                  title: Text(Room.configureRoomName(user, allUsers, room)),
                ),
                body: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
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
