import 'package:boochat_ui/src/layout_widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../active_room/active_room.dart';
import '../create_room/create_room.dart';
import '../layout_widgets/error_screen.dart';
import '../meetups/meetups_wrapper.dart';
import '../room_list/room_list.dart';
import 'route_names.dart';

class MobileScaffold extends StatelessWidget {
  final Widget child;
  final bool withBottomNavBar;
  const MobileScaffold(
      {required this.child, this.withBottomNavBar = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: (_, __) => false,
      pages: [
        MaterialPage(
            child: SafeArea(
          child: Scaffold(
            body: child,
            bottomNavigationBar:
                withBottomNavBar ? const BottomNavigation() : null,
          ),
        ))
      ],
    );
  }
}

final mobileRouter = GoRouter(
    navigatorBuilder: (context, state, widget) {
      return MobileScaffold(
          child: widget,
          withBottomNavBar: !state.location.contains(RouteNames.room));
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
