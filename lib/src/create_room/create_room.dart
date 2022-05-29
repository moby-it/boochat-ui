import 'package:boochat_ui/src/common/common.dart';
import 'package:boochat_ui/src/create_room/user_card.dart';
import 'package:boochat_ui/src/data/models/models.dart';
import 'package:boochat_ui/src/data/websocket_events.dart';
import 'package:boochat_ui/src/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:go_router/go_router.dart';

import '../routes/route_names.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({Key? key}) : super(key: key);
  static const routeName = '/create-room';

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  List<User> selectedUsers = [];

  @override
  Widget build(BuildContext context) {
    final allUsers = context.read<UsersBloc>().state.allUsers;
    return Scaffold(
      appBar: !kIsWeb ? AppBar(title: const Text("Create room")) : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: kIsWeb ? 58 : 29),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ChipsInput<User>(
                chipBuilder: (context, state, user) => InputChip(
                      backgroundColor: Theme.of(context).cardColor,
                      label: SizedBox(
                        width: 133,
                        height: 32,
                        child: Row(
                          children: <Widget>[
                            CachedNetworkImage(
                                width: 24,
                                height: 24,
                                imageUrl: user.imageUrl!),
                            const SizedBox(width: 8),
                            Text(user.name!)
                          ],
                        ),
                      ),
                      onDeleted: () {
                        state.deleteChip(user);
                      },
                    ),
                suggestionBuilder: (context, state, user) =>
                    UserCard(user: user),
                findSuggestions: (String query) {
                  if (query.isEmpty) {
                    return List.empty();
                  }
                  return allUsers
                      .where((user) => user.name!
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                },
                onChanged: (data) {
                  selectedUsers = data;
                }),
            const SizedBox(height: 56),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(176, 201, 231, 1)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12))),
                    onPressed: () {
                      debugPrint(selectedUsers.toString());
                      final webSocketManager = context.read<WebsocketManager>();
                      final currentUser = context.read<AuthBloc>().state.user;
                      webSocketManager.commandSocket
                          .emit(WebsocketEvents.createRoom, {
                        'name':
                            "${currentUser.name}${selectedUsers.map((user) => ", ${user.name}")}",
                        'imageUrl': 'empty_room.png',
                        'participants': [
                          currentUser.name,
                          ...selectedUsers.map((e) => e.name)
                        ]
                      });
                    },
                    child: Text("CREATE ROOM",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: backgroundColor))),
                const SizedBox(
                  width: 48,
                ),
                TextButton(
                    child: const Text(
                      "CANCEL",
                      style: TextStyle(color: Color.fromRGBO(176, 201, 231, 1)),
                    ),
                    onPressed: () {
                      selectedUsers = [];
                      context.pop();
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
