import 'package:flutter/material.dart';

class BoochatTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
        primaryColor: const Color.fromRGBO(24, 39, 57, 1),
        scaffoldBackgroundColor: const Color.fromRGBO(12, 20, 45, 1),
        hoverColor: const Color.fromRGBO(24, 39, 57, 1),
        backgroundColor: const Color.fromRGBO(47, 64, 86, 1),
        textTheme: Typography.material2014().white.copyWith(
            caption:
                const TextStyle(color: Color.fromRGBO(240, 240, 240, 0.5))));
  }
}
