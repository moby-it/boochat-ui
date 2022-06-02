import 'package:boochat_ui/src/create_room/user_card.dart';
import 'package:boochat_ui/src/create_room/user_chip.dart';
import 'package:boochat_ui/src/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    final allUsers = context.read<UsersBloc>().state.allUsers;
    final currentUser = context.read<AuthBloc>().state.user;
    final availableUsers = allUsers
        .where((user) => user != currentUser && !selectedUsers.contains(user))
        .toList();
    return Scaffold(
      appBar: !kIsWeb
          ? AppBar(
              title: const Text(
              "Create room",
            ))
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kIsWeb ? 58 : 29, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (selectedUsers.isNotEmpty)
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Wrap(
                    children: selectedUsers
                        .map((user) => Row(
                              children: [
                                UserChip(
                                  user: user,
                                  deleteHandler: () {
                                    setState(() {
                                      selectedUsers.remove(user);
                                      availableUsers.add(user);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ),
            LayoutBuilder(
              builder: (context, constraints) => RawAutocomplete<User>(
                  textEditingController: controller,
                  focusNode: focusNode,
                  fieldViewBuilder: (context, textEditingController, focusNode,
                          onFieldSubmitted) =>
                      TextFormField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          onFieldSubmitted: (value) {
                            onFieldSubmitted();
                          }),
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return availableUsers;
                    } else {
                      return availableUsers.where((user) => user.name!
                          .toLowerCase()
                          .contains(textEditingValue.text));
                    }
                  },
                  onSelected: (user) {
                    setState(() {
                      selectedUsers.add(user);
                      availableUsers.remove(user);
                      controller.clear();
                    });
                  },
                  displayStringForOption: (user) => user.name!,
                  optionsViewBuilder: (context, onSelected, users) {
                    return Container(
                      alignment: Alignment.topLeft,
                      child: Material(
                        child: SizedBox(
                          width: constraints.biggest.width,
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 0),
                              itemCount: users.length,
                              itemBuilder: (context, index) => GestureDetector(
                                  onTap: () =>
                                      onSelected(users.elementAt(index)),
                                  child:
                                      UserCard(user: users.elementAt(index)))),
                        ),
                      ),
                    );
                  }),
            ),
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
                            "${currentUser.name}${selectedUsers.map((user) => user.name).reduce((value, element) => value = "${value ?? ""}, $element")}",
                        'imageUrl':
                            'https://cdn-icons-png.flaticon.com/512/1453/1453729.png',
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
                      selectedUsers.clear();
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
