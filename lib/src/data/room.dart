import 'package:equatable/equatable.dart';

import 'room_item.dart';
import 'user.dart';

class Room extends Equatable {
  final String id;
  final String name;
  final List<RoomItem> items;
  final List<User> participants;
  final String imageUrl;
  final bool hasUnreadMessage;
  const Room(
      {required this.id,
      required this.name,
      required this.items,
      required this.participants,
      required this.imageUrl,
      required this.hasUnreadMessage});
  Room.fromJson(dynamic json)
      : id = json['id'],
        imageUrl = json['imageUrl'],
        name = json['name'],
        participants = (json['participants'] as List<dynamic>)
            .map((e) => User.fromJson(e))
            .toList(),
        items = (json['items'] as List<dynamic>)
            .map((e) => RoomItem.fromJson(e))
            .toList(),
        hasUnreadMessage = json['hasUnreadMessage'];
  @override
  List<Object?> get props =>
      [id, name, participants, imageUrl, hasUnreadMessage, items];
}
