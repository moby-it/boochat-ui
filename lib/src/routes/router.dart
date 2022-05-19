import 'package:boochat_ui/src/active_room/active_room.dart';
import 'package:boochat_ui/src/create_room/create_room.dart';
import 'package:boochat_ui/src/layout_widgets/web_shell.dart';
import 'package:boochat_ui/src/meetups/meetups_wrapper.dart';
import 'package:boochat_ui/src/room_list/room_list.dart';
import 'package:boochat_ui/src/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../layout_widgets/error_screen.dart';

final webRouter = GoRouter(
    navigatorBuilder: ((context, state, child) => WebApp(
            child: Scaffold(
          body: child,
        ))),
    routes: [
      GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const Text("No active Room selected"),
          routes: [
            GoRoute(
                path: 'room/:id',
                name: RouteNames.room,
                pageBuilder: (context, state) {
                  var roomId = state.params['id'];
                  if (roomId == null) {
                    return const NoTransitionPage(
                        child: Text("no room seledted"));
                  } else {
                    return NoTransitionPage(child: ActiveRoom(roomId: roomId));
                  }
                })
          ])
    ],
    errorBuilder: (context, state) => const ErrorScreen());
final mobileRouter = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    navigatorBuilder: (context, state, widget) {
      return SafeArea(child: widget);
    },
    routes: [
      GoRoute(
          path: '/',
          name: RouteNames.roomList,
          builder: (context, state) => RoomListWrapper(key: state.pageKey)),
      GoRoute(
          path: '/room/:id',
          name: RouteNames.room,
          builder: (context, state) {
            var roomId = state.params['id'];
            if (roomId == null) throw Exception("navigated to room with no id");
            return ActiveRoom(key: state.pageKey, roomId: roomId);
          }),
      GoRoute(
          path: '/create-room',
          name: RouteNames.createRoom,
          builder: (context, state) => const CreateRoom()),
      GoRoute(
          path: '/meetups',
          name: RouteNames.meetupsList,
          builder: (context, state) => MeetupListWrapper(key: state.pageKey))
    ],
    errorBuilder: (context, state) => const ErrorScreen());
