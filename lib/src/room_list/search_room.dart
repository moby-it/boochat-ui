import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchRoom extends StatefulWidget {
  const SearchRoom({Key? key}) : super(key: key);

  @override
  State<SearchRoom> createState() => _SearchRoomState();
}

class _SearchRoomState extends State<SearchRoom> {
  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: TextFormField(
        key: _formKey,
        controller: controller,
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: "Search..."),
      ),
    );
  }
}
