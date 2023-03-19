import 'package:flutter/material.dart';

import 'colors.dart';
import 'spacings.dart';

ThemeData appThemeData = ThemeData(
  scaffoldBackgroundColor: darkBackground,
  appBarTheme: const AppBarTheme(
    color: darkBackground,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: primaryGray),
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.grey,
    indent: x4,
    endIndent: x4,
    thickness: 0.2,
  ),
  iconTheme: const IconThemeData(color: primaryGray),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18.0,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(fontSize: 16.0, color: primaryGray),
  ),
);
