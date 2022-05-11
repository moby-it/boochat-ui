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
        dateSent = DateTime.parse(json['timestamp']);
  @override
  List<Object?> get props => [id, content, dateSent, roomId];
}

class Message extends RoomItem {
  final User sender;

  const Message(
      {required String id,
      required String content,
      required String roomId,
      required DateTime dateSent,
      required this.sender})
      : super(
          id: id,
          content: content,
          roomId: roomId,
          dateSent: dateSent,
        );
  Message.fromJson(dynamic json)
      : sender = User.fromJson(Map.from(json['sender'])),
        super(
            content: json['content'],
            id: json['id'],
            dateSent: DateTime.parse(json['timestamp']).toLocal(),
            roomId: json['roomId']);
}

class Announcement extends RoomItem {
  const Announcement(
      {required String id,
      required String content,
      required String roomId,
      required DateTime dateSent})
      : super(id: id, content: content, roomId: roomId, dateSent: dateSent);
  Announcement.fromJson(dynamic json)
      : super(
            content: json['content'],
            id: json['id'],
            dateSent: DateTime.parse(json['timestamp']).toLocal(),
            roomId: json['roomId']);
}
