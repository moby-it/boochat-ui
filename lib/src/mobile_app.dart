import 'package:boochat_ui/src/active-room/active_room.dart';
import 'package:boochat_ui/src/room-list/room_list.dart';
import 'package:boochat_ui/src/shared/auth_bloc/auth_bloc.dart';
import 'package:boochat_ui/src/shared/auth_bloc/auth_events.dart';
import 'package:boochat_ui/src/shared/auth_bloc/auth_repository.dart';
import 'package:boochat_ui/src/shared/websocket_bloc/websocket_bloc.dart';
import 'package:boochat_ui/src/shared/websocket_bloc/websocket_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileApp extends StatelessWidget {
  final AuthRepository authRepository;
  final WebsocketManager websocketManager;
  const MobileApp(
      {required this.authRepository, required this.websocketManager, Key? key})
      : super(key: key);

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
                  child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<AuthRepository>.value(value: authRepository),
              RepositoryProvider<WebsocketManager>.value(
                  value: websocketManager)
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  lazy: false,
                  create: (_) => AuthBloc(authRepository)..add(Login()),
                ),
                BlocProvider(
                    lazy: false,
                    create: (context) => WebsocketBloc(
                        websocketManager, context.read<AuthBloc>()))
              ],
              child: const Text("I rendered and supposedely loggeg in"),
            ),
          )));
        });
  }
}
