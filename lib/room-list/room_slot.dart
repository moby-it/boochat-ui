import 'package:boochat_ui/shared/room_model.dart';
import 'package:flutter/cupertino.dart';

class RoomSlot extends StatelessWidget {
  const RoomSlot({required this.room, Key? key}) : super(key: key);
  final RoomModel room;
  @override
  Widget build(BuildContext context) {
    return Text(room.name);
  }
}
