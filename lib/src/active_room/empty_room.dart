import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyRoom extends StatelessWidget {
  const EmptyRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const assetName = 'assets/empty-room.svg';
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(0, 29, 52, 1)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              assetName,
              width: 270,
              height: 270,
            ),
            Text("Nothing here but sad ghosts!",
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Choose a room and start chatting.",
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ]),
    );
  }
}
