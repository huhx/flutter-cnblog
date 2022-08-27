import 'package:shared_preferences/shared_preferences.dart';

class PrefsUtil {
  static late SharedPreferences prefs;
  static const isLightTheme = "app.theme.light";

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void saveIsLightTheme(bool isLight) {
    prefs.setBool(isLightTheme, isLight);
  }

  static bool? getIsLightTheme() {
    return prefs.getBool(isLightTheme);
  }
}
