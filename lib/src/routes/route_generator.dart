import 'package:boochat_ui/src/active_room/active_room.dart';
import 'package:boochat_ui/src/create_room/create_room.dart';
import 'package:boochat_ui/src/routes/route_names.dart';
import 'package:boochat_ui/src/web_screens/main_web_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
    Widget routeWidget;
    if (settings.name!.contains("room")) {
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

    if (kIsWeb) {
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation1, animation2) => MainWebScreen(
                child: routeWidget,
              ),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero);
    } else {
      return MaterialPageRoute(builder: (context) => routeWidget);
    }
  }
}
