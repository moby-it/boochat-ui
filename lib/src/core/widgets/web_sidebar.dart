import 'package:flutter/material.dart';

class WebSidebar extends StatelessWidget {
  const WebSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Icon(
              Icons.person_rounded,
              size: 32,
            ),
            SizedBox(
              height: 24,
            ),
            Icon(
              Icons.settings,
              size: 32,
            )
          ],
        ),
      ),
    );
  }
}
