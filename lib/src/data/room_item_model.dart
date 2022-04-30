import 'room_model.dart';
import 'user_model.dart';

class RoomItemModel {
  late String id;
  late String content;
  late DateTime dateSent;
  late RoomModel room;
  late DateTime timestamp;
  RoomItemModel({required this.id, required this.content});
  RoomItemModel.fromJson(dynamic json)
      : content = json['content'],
        id = json['id'];
}

mixin MessageModel on RoomItemModel {
  late UserModel sender;
}
mixin AnnouncementModel on RoomItemModel {
  late String roomId;
}
