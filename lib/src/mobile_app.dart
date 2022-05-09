import 'package:boochat_ui/src/active-room/active_room.dart';
import 'package:boochat_ui/src/room-list/room_list.dart';
import 'package:boochat_ui/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/common.dart';

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
        theme: BoochatTheme.darkTheme,
        // theme: BoochatTheme.darkTheme,
        title: 'Boochat UI',
        initialRoute: '/',
        routes: {
          '/': (context) => const RoomListWrapper(),
          ActiveRoom.routeName: (context) => ActiveRoom()
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
                        websocketManager, context.read<AuthBloc>())),
              ],
              child: BlocBuilder<WebsocketBloc, WebsocketState>(
                  builder: (context, state) {
                if (state is WebSocketConnectedState) {
                  return Container(child: navigator);
                } else {
                  return const Text("connecting...");
                }
              }),
            ),
          )));
        });
  }
}
