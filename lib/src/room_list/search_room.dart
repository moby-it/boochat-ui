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
    return SizedBox(
      height: 43,
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: controller,
          onFieldSubmitted: (String value) {
            debugPrint(value);
          },
          textInputAction: TextInputAction.go,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 43 / 2),
              prefixIcon: Icon(Icons.search),
              hintText: "Search..."),
        ),
      ),
    );
  }
}
