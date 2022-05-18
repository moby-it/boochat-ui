import 'package:boochat_ui/src/meetups/meetups_wrapper.dart';
import 'package:boochat_ui/src/room_list/room_list.dart';
import 'package:boochat_ui/src/routes/route_generator.dart';
import 'package:boochat_ui/src/theme.dart';
import 'package:flutter/material.dart';

import './web_sidebar.dart';

class WebShell extends StatelessWidget {
  const WebShell({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: BoochatTheme.darkTheme,
      onGenerateRoute: RouteGenerator.generateWebRoute,
      builder: (context, navigator) => SafeArea(
        child: Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                  width: 110, height: double.infinity, child: WebSidebar()),
              const Expanded(flex: 2, child: RoomListWrapper()),
              Expanded(flex: 3, child: Container(child: navigator)),
              const Expanded(flex: 3, child: MeetupListWrapper())
              // ActiveRoom()
            ],
          ),
        ),
      ),
    );
  }
}
