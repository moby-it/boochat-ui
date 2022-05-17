import 'package:boochat_ui/src/common/route_provider.dart';
import 'package:boochat_ui/src/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeState = context.read<RouteState>();
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).backgroundColor,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_rounded),
          label: "Rooms",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_rounded),
          label: "Meetups",
        ),
      ],
      onTap: (int index) {
        if (index != context.read<RouteState>().activeRouteIndex) {
          if (index == 0) {
            routeState.setActiveRoute(RouteNames.roomList, index);
            Navigator.pushNamed(context, RouteNames.roomList);
          } else if (index == 1) {
            routeState.setActiveRoute(RouteNames.meetupsList, index);
            Navigator.pushNamed(context, RouteNames.meetupsList);
          }
        }
      },
      currentIndex: context.watch<RouteState>().activeRouteIndex,
    );
  }
}
