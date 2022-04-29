import '../shared/user_model.dart';
import 'room.dart';

class RoomItem {
  late String id;
  late String content;
  late DateTime dateSent;
  late Room room;
  late DateTime timestamp;
  RoomItem({required this.id, required this.content});
  RoomItem.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        id = json['id'];
}

mixin Message on RoomItem {
  late User sender;
}
mixin Announcement on RoomItem {
  late String roomId;
}
