import 'package:boochat_ui/src/shared.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RoomSlot extends StatelessWidget {
  const RoomSlot({required this.room, Key? key}) : super(key: key);
  final RoomModel room;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).hoverColor),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: room.imageUrl,
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(room.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white)),
                    Text(room.items.last.content)
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
