import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/route_provider.dart';
import '../layout_widgets/bottom_navigation.dart';

class MeetupListWrapper extends StatelessWidget {
  const MeetupListWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !kIsWeb ? AppBar(title: const Text("Meetups")) : null,
      body: WillPopScope(
          onWillPop: (() async {
            context.read<RouteState>().pop();
            return true;
          }),
          child: const Text("meetupsnot yet implemented")),
      bottomNavigationBar: !kIsWeb ? const BottomNavigation() : null,
    );
  }
}
