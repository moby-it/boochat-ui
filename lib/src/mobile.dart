import 'package:boochat_ui/src/active-room/active_room.dart';
import 'package:boochat_ui/src/providers/providers.dart';
import 'package:boochat_ui/src/room-list/room_list.dart';
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
          return Scaffold(
              body: SafeArea(
                  child: FutureBuilder(
            future: context.read<AuthProvider>().login(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Provider(
                    create: (context) => AppStateProvider(context),
                    child: navigator);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("loading");
              } else {
                return const Text("Failed to login");
              }
            },
          )));
        });
  }
}
