import 'package:boochat_ui/src/meetups/meetups_wrapper.dart';
import 'package:boochat_ui/src/room_list/room_list.dart';
import 'package:boochat_ui/src/theme.dart';
import 'package:flutter/material.dart';

import './web_sidebar.dart';
import '../routes/router.dart';

class WebShell extends StatelessWidget {
  final Widget child;
  const WebShell({required this.child, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(
            width: 110, height: double.infinity, child: WebSidebar()),
        const Expanded(flex: 2, child: RoomListWrapper()),
        Expanded(
          flex: 3,
          child: child,
        ),
        const Expanded(flex: 3, child: MeetupListWrapper())
        // ActiveRoom()
      ],
    );
  }
}

class WebApp extends StatelessWidget {
  const WebApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: BoochatTheme.darkTheme,
      routeInformationParser: webRouter.routeInformationParser,
      routerDelegate: webRouter.routerDelegate,
    );
  }
}
