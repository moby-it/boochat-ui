import 'package:boochat_ui/src/routes/route_names.dart';
import 'package:flutter/material.dart';

class RouteState extends ChangeNotifier {
  String activeRoute;
  int activeRouteIndex;
  RouteState()
      : activeRoute = RouteNames.roomList,
        activeRouteIndex = 0;
  void setActiveRoute(String route, int index) {
    activeRoute = route;
    activeRouteIndex = index;
    notifyListeners();
  }
}
