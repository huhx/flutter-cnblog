import 'package:flutter/material.dart';
import 'package:flutter_cnblog/util/prefs_util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeProvider = ChangeNotifierProvider((ref) {
  final isLightTheme = PrefsUtil.getIsLightTheme();
  if (isLightTheme == null) {
    return AppThemeState(ThemeMode.system);
  }
  return AppThemeState(isLightTheme ? ThemeMode.light : ThemeMode.dark);
});

class AppThemeState extends ChangeNotifier {
  ThemeMode themeMode;

  AppThemeState(this.themeMode);

  void setDark(bool isDark) {
    PrefsUtil.saveIsLightTheme(!isDark);
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    
    notifyListeners();
  }
}
