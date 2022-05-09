import 'package:boochat_ui/src/common/common.dart';
import 'package:boochat_ui/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_web_screen.dart';

class WebApp extends StatelessWidget {
  final AuthRepository authRepository;
  final WebsocketManager websocketManager;
  const WebApp(
      {required this.authRepository, required this.websocketManager, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: BoochatTheme.darkTheme,
        // theme: BoochatTheme.darkTheme,
        title: 'Boochat UI',
        initialRoute: '/',
        routes: {'/': (context) => const MainWebScreen()},
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
