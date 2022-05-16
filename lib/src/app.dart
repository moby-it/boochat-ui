import 'package:boochat_ui/src/active_room/bloc/active_room_bloc.dart';
import 'package:boochat_ui/src/room_list/bloc/room_list_bloc.dart';
import 'package:boochat_ui/src/routes/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/common.dart';
import 'data/data.dart';
import 'theme.dart';

class App extends StatelessWidget {
  final AuthRepository authRepository;
  final WebsocketManager websocketManager;
  final RoomRepository roomRepository;
  const App(
      {required this.authRepository,
      required this.websocketManager,
      required this.roomRepository,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: BoochatTheme.darkTheme,
        // theme: BoochatTheme.darkTheme,
        title: 'Boochat UI',
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        builder: (context, navigator) {
          return Scaffold(
              body: SafeArea(
                  child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<AuthRepository>.value(value: authRepository),
              RepositoryProvider<WebsocketManager>.value(
                  value: websocketManager),
              RepositoryProvider<RoomRepository>.value(value: roomRepository)
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  lazy: false,
                  create: (_) => AuthBloc(authRepository)
                    ..add(
                      Login(),
                    ),
                ),
                BlocProvider(
                  create: (_) => UsersBloc(websocketManager),
                  lazy: false,
                ),
                BlocProvider(
                  create: ((_) => RoomListBloc(websocketManager)),
                  lazy: false,
                ),
                BlocProvider(
                  create: (_) => ActiveRoomBloc(websocketManager),
                ),
              ],
              child: MultiBlocListener(
                listeners: [
                  BlocListener<AuthBloc, AuthState>(listener: (context, state) {
                    if (state.status == AuthStatus.authenticated) {
                      websocketManager.connect(state.token);
                    }
                  })
                ],
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final status = state.status;
                    if (status != AuthStatus.authenticated) {
                      return Text(status.name);
                    } else {
                      return StreamBuilder(
                          stream: websocketManager.socketsConnected$,
                          builder: (context, AsyncSnapshot<bool> snapshot) {
                            if (snapshot.hasData) {
                              return BlocBuilder<UsersBloc, UsersState>(
                                  builder: (context, state) =>
                                      state.allUsers.isEmpty
                                          ? const Text("fetching users")
                                          : Container(child: navigator));
                            } else {
                              return const Text("connecting...");
                            }
                          });
                    }
                  },
                ),
              ),
            ),
          )));
        });
  }
}
