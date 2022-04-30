import 'room_item_model.dart';
import 'user_model.dart';

class RoomModel {
  late String id;
  late String name;
  late List<RoomItemModel> items;
  late List<UserModel> participants;
  late String imageUrl;
  late bool hasUnreadMessage;
  RoomModel(
      {required this.id,
      required this.name,
      required this.items,
      required this.participants,
      required this.imageUrl,
      required this.hasUnreadMessage});
  RoomModel.fromJson(dynamic json)
      : id = json['id'],
        imageUrl = json['imageUrl'],
        name = json['name'],
        participants = (json['participants'] as List<dynamic>)
            .map((e) => UserModel.fromJson(e))
            .toList(),
        items = (json['items'] as List<dynamic>)
            .map((e) => RoomItemModel.fromJson(e))
            .toList(),
        hasUnreadMessage = json['hasUnreadMessage'];
}
