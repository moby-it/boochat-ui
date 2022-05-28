import 'package:boochat_ui/src/meetups/meetups_wrapper.dart';
import 'package:boochat_ui/src/theme.dart';
import 'package:flutter/material.dart';

import './web_sidebar.dart';
import '../room_list/room_list_wrapper.dart';
import '../routes/router.dart';

class WebShell extends StatelessWidget {
  final Widget child;
  const WebShell({required this.child, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: BoochatTheme.darkTheme,
      home: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
                width: 128,
                height: MediaQuery.of(context).size.height,
                child: const WebSidebar()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
              child: Row(
                children: [
                  Container(
                    width: 1002,
                    padding: const EdgeInsets.fromLTRB(24, 43, 24, 12),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(children: [
                      const SizedBox(width: 304, child: RoomListWrapper()),
                      SizedBox(width: 638, child: child)
                    ]),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Container(
                    width: 630,
                    height: 905,
                    color: Theme.of(context).backgroundColor,
                    child: const MeetupListWrapper(),
                  )
                ],
              ),
            ),

            // ActiveRoom()
          ],
        ),
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
