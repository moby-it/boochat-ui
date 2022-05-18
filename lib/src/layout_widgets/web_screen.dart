import 'package:boochat_ui/src/meetups/meetups_wrapper.dart';
import 'package:boochat_ui/src/room_list/room_list.dart';
import 'package:boochat_ui/src/routes/router.dart';
import 'package:boochat_ui/src/theme.dart';
import 'package:flutter/material.dart';

import './web_sidebar.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  final WebRouterDelegete _routerDelegate = WebRouterDelegete();
  final WebRouteInformationParser _routeInformationParser =
      WebRouteInformationParser();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: BoochatTheme.darkTheme,
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
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
