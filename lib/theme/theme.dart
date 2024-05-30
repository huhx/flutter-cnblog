import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color themeColor = Color(0xFFEE5F8A);

enum AppTheme { light, dark }

final appThemeData = {
  AppTheme.light: ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 242, 242, 247),
    brightness: Brightness.light,
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyMedium: const TextStyle(fontSize: 14.0),
      bodyLarge: const TextStyle(fontSize: 16.0),
    ),
    cardTheme: const CardTheme(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: themeColor,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 17),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 20),
    ),
    primaryColor: themeColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: themeColor,
    ),
    bottomSheetTheme: const BottomSheetThemeData(modalBackgroundColor: Color.fromRGBO(247, 248, 250, 1)),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    colorScheme: ColorScheme.light(
      surface: Colors.white.withOpacity(0.5),
    ),
  ),
  AppTheme.dark: ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
    brightness: Brightness.dark,
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyMedium: const TextStyle(fontSize: 14.0, color: Colors.white),
      bodyLarge: const TextStyle(fontSize: 16.0, color: Colors.white),
    ),
    cardTheme: const CardTheme(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 17),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 20),
    ),
    dialogTheme: const DialogTheme(
      titleTextStyle: TextStyle(color: Colors.white),
      contentTextStyle: TextStyle(color: Colors.white),
    ),
    primaryColor: themeColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: themeColor,
    ),
    bottomSheetTheme: const BottomSheetThemeData(modalBackgroundColor: Colors.black),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    colorScheme: const ColorScheme.dark(
      surface: Color.fromRGBO(30, 30, 30, 1),
    ),
  )
};
