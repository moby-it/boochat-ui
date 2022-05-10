import 'package:equatable/equatable.dart';

import 'user.dart';

class RoomItem extends Equatable {
  final String id;
  final String content;
  final DateTime dateSent;
  final String roomId;
  const RoomItem(
      {required this.id,
      required this.content,
      required this.roomId,
      required this.dateSent});
  RoomItem.fromJson(dynamic json)
      : content = json['content'],
        id = json['id'],
        roomId = json['roomId'],
        dateSent = DateTime.now();
  @override
  List<Object?> get props => [id, content, dateSent, roomId];
}

mixin MessageModel on RoomItem {
  late User sender;
}
mixin AnnouncementModel on RoomItem {}
