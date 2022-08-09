import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color themeColor = Color(0xFFEE5F8A);

enum AppTheme { light, dark }

final appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.latoTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: themeColor,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 18),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 20),
    ),
    primaryColor: themeColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: themeColor,
    ),
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.latoTextTheme(),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 18),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 20),
    ),
    primaryColor: themeColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: themeColor,
    ),
  )
};
