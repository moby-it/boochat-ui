import 'package:boochat_ui/src/active-room/bloc/active_room_bloc.dart';
import 'package:boochat_ui/src/active-room/bloc/active_room_state.dart';
import 'package:boochat_ui/src/active-room/message_input.dart';
import 'package:boochat_ui/src/active-room/room_item_bubble.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../common/common.dart';
import '../data/data.dart';

class ActiveRoom extends StatelessWidget {
  ActiveRoom({Key? key}) : super(key: key);
  final queryUri = dotenv.env["QUERY_URI"];
  static const routeName = '/rooms';

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().state.user;
    final allUsers = context.read<UsersBloc>().state.allUsers;
    if (queryUri == null) {
      throw Exception("cannot fetch room with no query uri");
    }
    return BlocBuilder<ActiveRoomBloc, ActiveRoomState>(
      builder: (context, state) {
        if (state is NoActiveRoomSelectedState) {
          return const Text("no active noom selected");
        } else if (state is FetchingActiveRoomState) {
          return const Text("fetching room details...");
        } else {
          final room = (state as ActiveRoomSelectedState).room;
          final items = room.items.reversed.toList();
          return Scaffold(
            backgroundColor: Theme.of(context).hoverColor,
            appBar: kIsWeb
                ? null
                : AppBar(
                    title: Text(Room.configureRoomName(user, allUsers, room)),
                  ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.separated(
                        reverse: true,
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 20,
                            ),
                        itemCount: items.length,
                        itemBuilder: (context, index) =>
                            RoomItemBubble(roomItem: items[index])),
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
  }
}
