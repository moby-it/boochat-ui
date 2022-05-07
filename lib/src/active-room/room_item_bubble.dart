import 'package:boochat_ui/src/data/room_item.dart';
import 'package:flutter/material.dart';

class RoomItemBubble extends StatelessWidget {
  const RoomItemBubble({required this.roomItem, Key? key}) : super(key: key);
  final RoomItem roomItem;
  @override
  Widget build(BuildContext context) {
    return Text(roomItem.content);
  }
}
