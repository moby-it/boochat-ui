import 'room_item.dart';
import 'user.dart';

class Room {
  late final String id;
  late String name;
  late List<RoomItem> items;
  late List<User> participants;
  late String imageUrl;
  late bool hasUnreadMessage;
  Room(
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
}
