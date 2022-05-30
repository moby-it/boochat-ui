import 'package:boochat_ui/src/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/core.dart';
import '../data/data.dart';

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
    final currentUser = context.read<AuthBloc>().state.user;
    final otherUsers =
        allUsers.where((user) => user.id != currentUser.id).toList();
    return Scaffold(
      appBar: !kIsWeb ? AppBar(title: const Text("Create room")) : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kIsWeb ? 58 : 29, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text("Autcomplte chips stuff"),
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
                            "${currentUser.name}${selectedUsers.map((user) => user.name).reduce((value, element) => ", $element")}",
                        'imageUrl': 'empty_room.png',
                        'participantIds': [
                          currentUser.id,
                          ...selectedUsers.map((e) => e.id)
                        ]
                      });
                      context.pop();
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
