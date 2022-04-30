import 'package:boochat_ui/room-list/room_list.dart';
import 'package:boochat_ui/shared/providers/google_auth_provider.dart';
import 'package:boochat_ui/shared/providers/user_provider.dart';
import 'package:boochat_ui/shared/socket_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoochatMobileApp extends StatelessWidget {
  const BoochatMobileApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      // theme: BoochatTheme.darkTheme,
      title: 'Boochat UI',
      routes: {'/': (context) => const RoomListWrapper()},
      builder: (context, content) {
        return Scaffold(
          body: GoogleAuth(child: Consumer<GoogleUserModel>(
            builder: (context, userModel, child) {
              return ChangeNotifierProvider(
                  create: (context) => SocketManager(userModel.token),
                  child: content);
            },
          )),
        );
      },
    );
  }
}
