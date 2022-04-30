import 'package:boochat_ui/src/room-list/room_list.dart';
import 'package:boochat_ui/src/shared.dart';
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
      routes: {'/': (context) => const RoomListWrapper()},
      builder: (context, navigator) {
        return Scaffold(
          appBar: AppBar(title: const Text("Boochat"), centerTitle: true),
          body: Center(
            child: GoogleAuth(child: Consumer<GoogleUserModel>(
              builder: (context, userModel, child) {
                return ChangeNotifierProvider(
                    create: (context) => SocketManager(userModel.token),
                    child: navigator);
              },
            )),
          ),
        );
      },
    );
  }
}
