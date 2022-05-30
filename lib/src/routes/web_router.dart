import 'package:boochat_ui/src/active_room/empty_room.dart';
import 'package:boochat_ui/src/active_room/web/web_active_room.dart';
import 'package:boochat_ui/src/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/core.dart';
import '../create_room/create_room.dart';

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
            return const EmptyRoom();
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
                    return NoTransitionPage(
                        child: WebActiveRoom(roomId: roomId));
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
