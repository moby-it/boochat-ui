import 'package:boochat_ui/src/room_list/room_list.dart';
import 'package:boochat_ui/src/web_screens/web_sidebar.dart';
import 'package:flutter/material.dart';

class MainWebScreen extends StatelessWidget {
  final Widget child;
  const MainWebScreen({required this.child, Key? key}) : super(key: key);
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
        Expanded(flex: 3, child: child),
        // ActiveRoom()
      ],
    );
  }
}
