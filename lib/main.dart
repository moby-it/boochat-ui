import 'dart:convert';

import 'package:boochat_ui/room-list/room_list.dart';
import 'package:boochat_ui/shared/providers/google_auth_provider.dart';
import 'package:boochat_ui/shared/providers/user_provider.dart';
import 'package:boochat_ui/shared/room_model.dart';
import 'package:boochat_ui/shared/socket_manager.dart';
import 'package:boochat_ui/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: kDebugMode ? ".env" : "release.env");
  runApp(ChangeNotifierProvider(
    create: (context) => GoogleUserModel(),
    child: BoochatApp(),
  ));
}

class BoochatApp extends StatelessWidget {
  BoochatApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: BoochatTheme.themeData(context),
      child: WidgetsApp(
        title: 'Boochat UI',
        color: Theme.of(context).primaryColor,
        builder: (context, navigator) {
          return GoogleAuth(child: Consumer<GoogleUserModel>(
            builder: (context, userModel, child) {
              return ChangeNotifierProvider(
                create: (context) => SocketManager(userModel.token),
                child: Consumer<SocketManager>(
                    builder: (context, socketManager, child) {
                  if (socketManager.initialized) {
                    return StreamBuilder(
                        stream: socketManager.queryStream
                            .where((event) => event.name == "ROOM_LIST"),
                        builder:
                            (context, AsyncSnapshot<SocketEvent> snapshot) {
                          if (snapshot.hasData) {
                            final rooms = snapshot.data!.jsonData
                                .map((e) => RoomModel.fromJson(e))
                                .toList();

                            return RoomList(rooms: rooms);
                          } else {
                            return const Text('rooms loading');
                          }
                        });
                  } else {
                    return const Text('...socket manager initialing');
                  }
                }),
              );
            },
          ));
        },
      ),
    );
  }
}
