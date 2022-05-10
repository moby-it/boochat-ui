import 'package:boochat_ui/src/active-room/active_room.dart';
import 'package:boochat_ui/src/room-list/room_list.dart';
import 'package:boochat_ui/src/web_screens/web_sidebar.dart';
import 'package:flutter/cupertino.dart';

class MainWebScreen extends StatelessWidget {
  const MainWebScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(
            width: 100, height: double.infinity, child: WebSidebar()),
        const Expanded(child: RoomListWrapper()),
        Expanded(child: ActiveRoom())
        // ActiveRoom()
      ],
    );
  }
}
