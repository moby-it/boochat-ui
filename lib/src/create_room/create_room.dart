import 'package:boochat_ui/src/layout_widgets/bottom_navigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({Key? key}) : super(key: key);
  static const routeName = '/create-room';
  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !kIsWeb ? AppBar(title: const Text("Create room")) : null,
      body: const Text("not yet implemented"),
      bottomNavigationBar: !kIsWeb ? const BottomNavigation() : null,
    );
  }
}
