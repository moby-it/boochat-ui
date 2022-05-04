import 'package:boochat_ui/src/active-room/active_room.dart';
import 'package:boochat_ui/src/room-list/room_list.dart';
import 'package:boochat_ui/src/shared/shared.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => const RoomListWrapper(),
        ActiveRoomArgumentsScreen.routeName: (context) =>
            ActiveRoomArgumentsScreen()
      },
      builder: (context, navigator) {
        return SafeArea(
          child: GoogleAuthProvider(child: Consumer<AppUserModel>(
            builder: (context, userModel, child) {
              return ChangeNotifierProvider(
                  create: (context) => SocketManager(userModel.token),
                  child: navigator);
            },
          )),
        );
      },
    );
  }
}
