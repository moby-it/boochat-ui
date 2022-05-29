import 'package:flutter/material.dart';

class CreateRoomButton extends StatelessWidget {
  const CreateRoomButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: const [
        Icon(Icons.add_to_photos_outlined),
        SizedBox(
          width: 8,
        ),
        Text("Create Room")
      ]),
    );
  }
}
