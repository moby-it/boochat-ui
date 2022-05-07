import 'user.dart';

class RoomItem {
  late String id;
  late String content;
  late DateTime dateSent;
  late String roomId;
  late DateTime timestamp;
  RoomItem({required this.id, required this.content, required this.roomId});
  RoomItem.fromJson(dynamic json)
      : content = json['content'],
        id = json['id'],
        roomId = json['roomId'];
}

mixin MessageModel on RoomItem {
  late User sender;
}
mixin AnnouncementModel on RoomItem {}
