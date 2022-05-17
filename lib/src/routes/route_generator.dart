import 'package:boochat_ui/src/active_room/active_room.dart';
import 'package:boochat_ui/src/create_room/create_room.dart';
import 'package:boochat_ui/src/meetups/meetups_wrapper.dart';
import 'package:boochat_ui/src/room_list/room_list.dart';
import 'package:boochat_ui/src/routes/route_names.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<MaterialPageRoute> generateMobileRoute(RouteSettings settings) {
    Widget routeWidget;
    if (settings.name?.split("?")[0] == RouteNames.room) {
      String? roomId = settings.arguments as String?;
      roomId ??= Uri.base.queryParameters['id'];
      routeWidget = ActiveRoom(
        roomId: roomId!,
      );
    } else if (settings.name == RouteNames.createRoom) {
      routeWidget = const CreateRoom();
    } else if (settings.name == RouteNames.meetupsList) {
      routeWidget = const MeetupListWrapper();
    } else {
      routeWidget = const RoomListWrapper();
    }

    return MaterialPageRoute(
        settings: settings, builder: (context) => routeWidget);
  }

  static Route<MaterialPageRoute> generateWebRoute(RouteSettings settings) {
    Widget routeWidget;
    if (settings.name?.split("?")[0] == RouteNames.room) {
      String? roomId = settings.arguments as String?;
      roomId ??= Uri.base.queryParameters['id'];
      routeWidget = ActiveRoom(
        roomId: roomId!,
      );
    } else if (settings.name == RouteNames.createRoom) {
      routeWidget = const CreateRoom();
    } else {
      routeWidget = const Text("no active room selected");
    }
    return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) => routeWidget,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero);
  }
}
