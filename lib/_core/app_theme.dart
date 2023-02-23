import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_color.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    // backgroundColor: const Color.fromRGBO(51, 51, 51, 1),
    primaryColor: const Color.fromRGBO(51, 51, 51, 1),
    canvasColor: const Color.fromRGBO(51, 51, 51, 1),
    primarySwatch: materialBlackColor,
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white, fontSize: 13)),
    dividerTheme:
        const DividerThemeData(color: Color.fromRGBO(115, 115, 115, 1)),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      // iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Color.fromRGBO(41, 41, 41, 1),
      actionsIconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
          color: materialWhiteColor, fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}
