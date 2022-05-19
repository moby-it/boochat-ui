import 'package:boochat_ui/src/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
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
          if (index != _selectedIndex) {
            if (index == 0) {
              setState(() {
                _selectedIndex = index;
              });
              context.pushNamed(RouteNames.roomList);
            } else if (index == 1) {
              setState(() {
                _selectedIndex = index;
              });
              context.pushNamed(RouteNames.meetupsList);
            }
          }
        },
        currentIndex: _selectedIndex);
  }
}
