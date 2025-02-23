import 'package:flutter/material.dart';

import 'colors.dart';
import 'spacings.dart';

ThemeData lightAppThemeData = ThemeData.light().copyWith(
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
    titleMedium: TextStyle(fontSize: 20.0, color: lightBlack),
    titleLarge: TextStyle(
      fontSize: 28.0,
      color: lightBlack,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(fontSize: 16.0, color: Colors.blueAccent),
  ),
);

ThemeData darkAppThemeData = ThemeData.dark().copyWith(
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
    titleMedium: TextStyle(fontSize: 20.0, color: darkWhite),
    titleLarge: TextStyle(
      fontSize: 28.0,
      color: darkWhite,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(fontSize: 16.0, color: Colors.blueAccent),
  ),
);
