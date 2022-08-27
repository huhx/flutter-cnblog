import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color themeColor = Color(0xFFEE5F8A);
const momentBgColor = Color(0xFFF5F6F9);

enum AppTheme { light, dark }

final appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.latoTextTheme(),
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
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.latoTextTheme(),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 17),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 20),
    ),
    primaryColor: themeColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: themeColor,
    ),
    bottomSheetTheme: const BottomSheetThemeData(modalBackgroundColor: Colors.black54),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  )
};
