import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor = Color.fromRGBO(123, 147, 175, 1);
const scaffoldBackgroundColor = Color.fromRGBO(0, 19, 34, 1);
const cardColor = Color.fromRGBO(25, 50, 74, 1);
const backgroundColor = Color.fromRGBO(0, 29, 52, 1);

class BoochatTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        backgroundColor: backgroundColor,
        cardColor: cardColor,
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
        ),
        appBarTheme:
            ThemeData.dark().appBarTheme.copyWith(backgroundColor: cardColor),
        textTheme: GoogleFonts.manropeTextTheme(const TextTheme(
            bodyMedium: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white),
            titleLarge: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            titleMedium: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            titleSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            labelMedium: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            labelSmall: TextStyle(
                fontSize: 12, color: Color.fromRGBO(207, 228, 255, 1)))));
  }
}
