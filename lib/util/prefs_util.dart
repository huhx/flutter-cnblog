import 'dart:convert';

import 'package:flutter_cnblog/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsUtil {
  static late SharedPreferences prefs;
  static const isLightTheme = "app.theme.light";
  static const userKey = "user";
  static const cookieKey = "cookie";
  static const startTimeKey = "start.time";

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveUser(User value) async {
    await prefs.setString(userKey, json.encode(value));
  }

  static User? getUser() {
    final String? jsonString = prefs.getString(userKey);
    return jsonString == null ? null : User.fromJson(json.decode(jsonString));
  }

  static Future<void> saveCookie(String cookie) async {
    await prefs.setString(cookieKey, cookie);
  }

  static String? getCookie() {
    return prefs.getString(cookieKey);
  }

  static void setStartTime(int timestamp) async {
    await prefs.setInt(startTimeKey, timestamp);
  }

  static int? getStartTime() {
    return prefs.getInt(startTimeKey);
  }

  static void saveIsLightTheme(bool isLight) {
    prefs.setBool(isLightTheme, isLight);
  }

  static bool? getIsLightTheme() {
    return prefs.getBool(isLightTheme);
  }

  static Future<void> removeKey(String key) async {
    await prefs.remove(key);
  }

  static Future<bool> logout() async {
    await removeKey(cookieKey);
    return prefs.remove(userKey);
  }
}
