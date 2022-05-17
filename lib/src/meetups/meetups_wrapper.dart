import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../layout_widgets/bottom_navigation.dart';

class MeetupListWrapper extends StatelessWidget {
  const MeetupListWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !kIsWeb ? AppBar(title: const Text("Meetups")) : null,
      body: const Text("meetupsnot yet implemented"),
      bottomNavigationBar: !kIsWeb ? const BottomNavigation() : null,
    );
  }
}
