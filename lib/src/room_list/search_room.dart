import 'package:flutter/material.dart';

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
    return Form(
      key: _formKey,
      child: SizedBox(
        height: 43,
        child: TextFormField(
          controller: controller,
          onFieldSubmitted: (String value) {
            debugPrint(value);
          },
          textInputAction: TextInputAction.go,
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search), hintText: "Search..."),
        ),
      ),
    );
  }
}
