import 'package:boochat_ui/src/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../active_room/active_room.dart';
import '../common/common.dart';
import '../create_room/create_room.dart';
import '../layout_widgets/error_screen.dart';
import '../layout_widgets/web_shell.dart';

final webRouter = GoRouter(
    navigatorBuilder: ((context, state, child) {
      setPageTitle("Boochat");
      return WebShell(
          child: Scaffold(
        body: child,
      ));
    }),
    routes: [
      GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) {
            return const Text("No active Room selected");
          },
          routes: [
            GoRoute(
                path: 'room/:id',
                name: RouteNames.room,
                pageBuilder: (context, state) {
                  var roomId = state.params['id'];
                  if (roomId == null) {
                    throw Exception("Invalid Route: no room selected");
                  } else {
                    return NoTransitionPage(child: ActiveRoom(roomId: roomId));
                  }
                }),
            GoRoute(
                path: 'create-room',
                name: RouteNames.createRoom,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: CreateRoom());
                })
          ])
    ],
    errorBuilder: (context, state) => const ErrorScreen());
