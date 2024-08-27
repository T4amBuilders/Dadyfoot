import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: Colors.orange),
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black),
      displayMedium: TextStyle(color: Colors.black54),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark)
        .copyWith(secondary: Colors.red),
    scaffoldBackgroundColor: Colors.grey[900],
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white70),
    ),
  );

  static final ThemeData greenTheme = ThemeData(
    primaryColor: Colors.green,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
        .copyWith(secondary: Colors.yellow),
    scaffoldBackgroundColor: Colors.green[50],
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Colors.green[800]),
      displayMedium: TextStyle(color: Colors.green[600]),
    ),
  );

  static final ThemeData redTheme = ThemeData(
    primaryColor: Colors.red,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
        .copyWith(secondary: Colors.blue),
    scaffoldBackgroundColor: Colors.red[50],
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Colors.red[800]),
      displayMedium: TextStyle(color: Colors.red[600]),
    ),
  );

  // Add more themes here
}
