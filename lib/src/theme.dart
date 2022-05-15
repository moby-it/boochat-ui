import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(24, 39, 57, 1);
const hoverColor = Color.fromRGBO(24, 39, 57, 1);
const scaffoldBackgroundColor = Color.fromRGBO(12, 20, 45, 1);
const backgroundColor = Color.fromRGBO(47, 64, 86, 1);

class BoochatTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        hoverColor: hoverColor,
        backgroundColor: backgroundColor,
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
        ),
        appBarTheme: ThemeData.dark()
            .appBarTheme
            .copyWith(backgroundColor: backgroundColor),
        textTheme: Typography.material2014().white.copyWith(
            caption:
                const TextStyle(color: Color.fromRGBO(240, 240, 240, 0.5))));
  }
}
