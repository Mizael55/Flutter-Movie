import 'package:flutter/material.dart';

class AppTheme {
  final Color primaryColor = Colors.indigo;

  static final ThemeData lightTheme = ThemeData().copyWith(
      appBarTheme: const AppBarTheme(
        color: Colors.indigo,
        elevation: 0,
      ),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
        iconColor: MaterialStateProperty.all(Colors.white),
      )));
}
