import 'package:flutter/cupertino.dart';

import '../active-room/active_room.dart';
import '../room-list/room_list.dart';

Map<String, WidgetBuilder> mobileRoutes() {
  return Map.from({
    '/': (context) => const RoomListWrapper(),
    ActiveRoom.routeName: (context) => ActiveRoom()
  });
}
