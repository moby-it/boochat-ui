import 'package:boochat_ui/src/active-room/active_room.dart';
import 'package:boochat_ui/src/providers/providers.dart';
import 'package:boochat_ui/src/room-list/room_list.dart';
import 'package:boochat_ui/src/shared/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileApp extends StatelessWidget {
  final AuthRepository authRepository;
  const MobileApp({required this.authRepository, Key? key}) : super(key: key);

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
            child: RepositoryProvider.value(
                value: authRepository,
                child: BlocProvider(
                  create: (_) => AuthBloc(authRepository),
                  child: Container(
                    child: navigator,
                  ),
                )),
          ));
        });
  }
}
