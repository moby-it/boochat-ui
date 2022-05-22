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
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
              width: 128,
              height: MediaQuery.of(context).size.height,
              child: const WebSidebar()),
          Container(
            width: 1002,
            height: 905,
            padding: const EdgeInsets.fromLTRB(24, 43, 24, 12),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              const Flexible(flex: 1, child: RoomListWrapper()),
              Flexible(
                flex: 2,
                child: child,
              ),
            ]),
          ),
          const SizedBox(
            width: 32,
          ),

          Container(
            width: 630,
            height: 905,
            child: const MeetupListWrapper(),
            color: Theme.of(context).backgroundColor,
          )
          // ActiveRoom()
        ],
      ),
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
