import 'package:boochat_ui/src/theme.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: BoochatTheme.darkTheme,
        home: const Center(
            child: Text(
          "There was an error ",
          style: TextStyle(color: Colors.red, fontSize: 24),
        )));
  }
}
