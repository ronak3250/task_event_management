//
// import 'package:flutter/material.dart';
//
// class Themes {
//   static final lightTheme = ThemeData.light().copyWith(
//     primaryColor: Colors.blue,
//     scaffoldBackgroundColor: Colors.white,
//   );
//
//   static final darkTheme = ThemeData.dark().copyWith(
//     primaryColor: Colors.black,
//     scaffoldBackgroundColor: Colors.grey[900],
//   );
// }
import 'package:flutter/material.dart';

class Themes {
  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue, // AppBar background color
      foregroundColor: Colors.white, // AppBar text and icon color
      elevation: 0, // Flat app bar
    ),
    textButtonTheme: TextButtonThemeData(style: ButtonStyle(textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.black)))),

    textTheme: TextTheme(

      bodyLarge: TextStyle(color: Colors.black87), // Default text color
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[200], // TextField background color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none, // Remove border
      ),
      hintStyle: TextStyle(color: Colors.black87), // Hint text color
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[850], // AppBar background color
      foregroundColor: Colors.white, // AppBar text and icon color
      elevation: 0, // Flat app bar
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // Default text color
      bodyMedium: TextStyle(color: Colors.white),
    ),
    textButtonTheme: TextButtonThemeData(style: ButtonStyle(textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)))),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800], // TextField background color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none, // Remove border
      ),
      hintStyle: TextStyle(color: Colors.grey[500]), // Hint text color
    ),
  );
}
