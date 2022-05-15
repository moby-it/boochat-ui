import 'package:boochat_ui/src/create_room/create_room.dart';
import 'package:flutter/cupertino.dart';

import '../active_room/active_room.dart';
import '../room_list/room_list.dart';

Map<String, WidgetBuilder> mobileRoutes() {
  return Map.from({
    '/': (context) => const RoomListWrapper(),
    ActiveRoom.routeName: (context) => ActiveRoom(),
    CreateRoom.routeName: (context) => const CreateRoom(),
  });
}
