import 'package:flutter/material.dart';

class BoochatTheme {
  static ThemeData themeData(BuildContext context) {
    return ThemeData.from(
      colorScheme: const ColorScheme.dark(
          primary: Colors.blueGrey, background: Colors.grey),
      textTheme: Typography.blackMountainView,
    );
  }
}

const primaryColor = Colors.amberAccent;
