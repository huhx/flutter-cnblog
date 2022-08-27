import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeProvider = ChangeNotifierProvider((ref) => AppThemeState(ThemeMode.system));

class AppThemeState extends ChangeNotifier {
  ThemeMode themeMode;

  AppThemeState(this.themeMode);

  void setDark(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
