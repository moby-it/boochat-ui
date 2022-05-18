import 'package:boochat_ui/src/routes/route_names.dart';
import 'package:flutter/material.dart';

class Page {
  final String route;
  final int index;
  Page(this.route, this.index);
}

class RouteState extends ChangeNotifier {
  List<Page> history;
  RouteState() : history = List.of([Page(RouteNames.roomList, 0)]);
  get activeRouteIndex => history.last.index;
  void setActiveRoute(String route, int index) {
    history.add(Page(route, index));
    notifyListeners();
  }

  void pop() {
    history.removeLast();
    notifyListeners();
  }
}
