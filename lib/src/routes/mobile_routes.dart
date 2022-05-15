import 'package:flutter/cupertino.dart';

import '../active_room/active_room.dart';
import '../room_list/room_list.dart';

Map<String, WidgetBuilder> mobileRoutes() {
  return Map.from({
    '/': (context) => const RoomListWrapper(),
    ActiveRoom.routeName: (context) => ActiveRoom()
  });
}
