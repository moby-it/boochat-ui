import 'package:boochat_ui/theme.dart';
import 'package:flutter/material.dart';

class WebApp extends StatelessWidget {
  const WebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: BoochatTheme.darkTheme,
      child: const Text('web app'),
    );
  }
}
