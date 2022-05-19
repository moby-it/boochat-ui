import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MeetupListWrapper extends StatelessWidget {
  const MeetupListWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !kIsWeb ? AppBar(title: const Text("Meetups")) : null,
      body: WillPopScope(
          onWillPop: (() async {
            return true;
          }),
          child: const Text("meetupsnot yet implemented")),
    );
  }
}
