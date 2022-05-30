import 'package:boochat_ui/src/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateRoomButton extends StatelessWidget {
  const CreateRoomButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(RouteNames.createRoom);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child:
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: const [
          Icon(Icons.add_to_photos_outlined),
          SizedBox(
            width: 8,
          ),
          Text("Create Room")
        ]),
      ),
    );
  }
}
