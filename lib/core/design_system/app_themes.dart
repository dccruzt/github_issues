import 'package:flutter/material.dart';

import 'colors.dart';
import 'spacings.dart';

ThemeData lightAppThemeData = ThemeData(
  scaffoldBackgroundColor: lightBackground,
  appBarTheme: const AppBarTheme(
    color: lightBackground,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: lightBlack),
  ),
  dividerTheme: const DividerThemeData(
    color: lightGrey,
    indent: x4,
    endIndent: x4,
    thickness: 0.2,
  ),
  iconTheme: const IconThemeData(color: lightGreen),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 18.0, color: lightBlack),
    bodyMedium: TextStyle(fontSize: 16.0, color: lightGrey),
    titleLarge: TextStyle(
      fontSize: 28.0,
      color: lightBlack,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(fontSize: 16.0, color: Colors.blueAccent),
  ),
);

ThemeData darkAppThemeData = ThemeData(
  scaffoldBackgroundColor: darkBackground,
  appBarTheme: const AppBarTheme(
    color: darkBackground,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: darkWhite),
  ),
  dividerTheme: const DividerThemeData(
    color: darkGrey,
    indent: x4,
    endIndent: x4,
    thickness: 0.2,
  ),
  iconTheme: const IconThemeData(color: lightGreen),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 18.0, color: darkWhite),
    bodyMedium: TextStyle(fontSize: 16.0, color: darkGrey),
    titleLarge: TextStyle(
      fontSize: 28.0,
      color: darkWhite,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(fontSize: 16.0, color: Colors.blueAccent),
  ),
);
