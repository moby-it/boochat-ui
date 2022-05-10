import 'package:boochat_ui/src/active-room/bloc/active_room_bloc.dart';
import 'package:boochat_ui/src/room-list/bloc/room_list_bloc.dart';
import 'package:boochat_ui/src/routes/mobile_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/common.dart';
import 'routes/web_routes.dart';
import 'theme.dart';

class App extends StatelessWidget {
  final AuthRepository authRepository;
  final WebsocketManager websocketManager;
  const App(
      {required this.authRepository, required this.websocketManager, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: BoochatTheme.darkTheme,
        // theme: BoochatTheme.darkTheme,
        title: 'Boochat UI',
        initialRoute: '/',
        routes: kIsWeb ? webRoutes() : mobileRoutes(),
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
                BlocProvider(
                    lazy: false,
                    create: (context) => UsersBloc(websocketManager)),
                BlocProvider(
                    lazy: false,
                    create: ((context) => RoomListBloc(websocketManager))),
                BlocProvider(create: (context) => ActiveRoomBloc())
              ],
              child: BlocBuilder<WebsocketBloc, WebsocketState>(
                  builder: (context, state) {
                if (state is WebSocketConnectedState) {
                  return BlocBuilder<UsersBloc, UsersState>(
                      builder: (context, state) => state.allUsers.isEmpty
                          ? const Text("fetching users")
                          : Container(child: navigator));
                } else {
                  return const Text("connecting...");
                }
              }),
            ),
          )));
        });
  }
}
