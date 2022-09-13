import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color themeColor = Color(0xFFEE5F8A);
const momentBgColor = Color(0xFFF5F6F9);
const disabledColor = Color.fromRGBO(220, 220, 220, 1);

enum AppTheme { light, dark }

final appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyText2: const TextStyle(fontSize: 14.0),
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
    backgroundColor: Colors.white,
    bottomSheetTheme: const BottomSheetThemeData(modalBackgroundColor: Color.fromRGBO(247, 248, 250, 1)),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyText2: const TextStyle(fontSize: 14.0, color: Colors.white),
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
    backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
    bottomSheetTheme: const BottomSheetThemeData(modalBackgroundColor: Colors.black),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  )
};
