import 'package:boochat_ui/src/meetups/meetups_wrapper.dart';
import 'package:boochat_ui/src/room_list/room_list.dart';
import 'package:boochat_ui/src/routes/router.dart';
import 'package:boochat_ui/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './web_sidebar.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  late final WebRouteInformationParser _routeInformationParser;
  late final RouteState _routeState;
  late final WebRouterDelegete _routerDelegate;
  @override
  void initState() {
    _routeInformationParser = WebRouteInformationParser();
    _routeState = RouteState(_routeInformationParser);
    _routerDelegate = WebRouterDelegete(_routeState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RouteStateScope(
      notifier: _routeState,
      child: MaterialApp.router(
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
      ),
    );
  }
}
