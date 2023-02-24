import 'package:boochat_ui/src/active_room/bloc/active_room_bloc.dart';
import 'package:boochat_ui/src/active_room/bloc/active_room_events.dart';
import 'package:boochat_ui/src/active_room/mobile/mobile_active_room.dart';
import 'package:boochat_ui/src/room_list/mobile/mobile_room_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/core.dart';
import '../create_room/create_room.dart';
import '../meetups/meetups_wrapper.dart';
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

final mobileRouter = GoRouter(routes: [
  GoRoute(
      path: '/',
      name: RouteNames.roomList,
      builder: (context, state) {
        context.read<ActiveRoomBloc>().add(const ClearActiveRoomEvent());
        return MobileRoomList(key: state.pageKey);
      }),
  GoRoute(
      path: '/room/:id',
      name: RouteNames.room,
      builder: (context, state) {
        var roomId = state.params['id'];
        if (roomId == null) throw Exception("navigated to room with no id");
        return MobileActiveRoom(key: state.pageKey, roomId: roomId);
      }),
  GoRoute(
      path: '/create-room',
      name: RouteNames.createRoom,
      builder: (context, state) => const CreateRoom()),
  GoRoute(
      path: '/meetups',
      name: RouteNames.meetupsList,
      builder: (context, state) => MeetupListWrapper(key: state.pageKey))
], errorBuilder: (context, state) => const ErrorScreen());
