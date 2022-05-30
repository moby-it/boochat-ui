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
        items = json['items'] != null
            ? (json['items'] as List<dynamic>)
                .map((e) => e['sender'] != null
                    ? Message.fromJson(e)
                    : Announcement.fromJson(e))
                .toList()
            : List.empty(),
        hasUnreadMessage = json['hasUnreadMessage'];
  static String configureRoomImageUrl(
      User user, List<User> allUsers, Room room) {
    if (room.participants.length > 2) return room.imageUrl;
    final otherUserId = room.participants.firstWhere((u) => u.id != user.id).id;
    final otherUser = allUsers.firstWhere((user) => user.id == otherUserId);
    return otherUser.imageUrl ?? room.imageUrl;
  }

  static String configureRoomName(User user, List<User> allUsers, Room room) {
    if (room.participants.length > 2) return room.name;
    final otherUserId = room.participants.firstWhere((u) => u.id != user.id).id;
    final otherUser = allUsers.firstWhere((user) => user.id == otherUserId);
    return otherUser.name ?? room.name;
  }

  String getOtherUserId(String currentUserId) =>
      participants.firstWhere((user) => user.id != currentUserId).id;
  bool lastMessageIsSent(String currentUserId) {
    if (items.isEmpty) {
      return false;
    }
    final lastItem = items.last;
    return lastItem is Message && lastItem.sender.id == currentUserId;
  }
}
