import 'package:flutter/material.dart';

class WebSidebar extends StatelessWidget {
  const WebSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Icon(
              Icons.person_rounded,
              size: 48,
            ),
            SizedBox(
              height: 30,
            ),
            Icon(
              Icons.settings,
              size: 48,
            )
          ],
        ),
      ),
    );
  }
}
