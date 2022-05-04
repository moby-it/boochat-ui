import 'package:boochat_ui/src/data/room_item_model.dart';
import 'package:boochat_ui/src/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({required this.roomItem, Key? key}) : super(key: key);
  final RoomItemModel roomItem;
  @override
  Widget build(BuildContext context) {
    return Consumer<AppUserModel>(builder: (context, userModel, child) {
      return Text(roomItem.content);
    });
  }
}
