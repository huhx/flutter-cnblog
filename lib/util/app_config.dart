class AppConfig {
  AppConfig._internal();

  static Map<String, dynamic> appConfig = <String, dynamic>{};

  static dynamic get(String key) {
    return _getValue(key);
  }

  static bool getBool(String key) {
    return _getValue(key) as bool;
  }

  static int getInt(String key) {
    return _getValue(key) as int;
  }

  static DateTime getTime(String key) {
    return _getValue(key) as DateTime;
  }

  static double getDouble(String key) {
    return _getValue(key) as double;
  }

  static String getString(String key) {
    return _getValue(key) as String;
  }

  static dynamic _getValue(String key) {
    final List<String> keys = key.split(".");
    if (keys.length == 1) return appConfig[key];
    return appConfig[keys[0]][keys[1]];
  }

  static void update(String key, dynamic value) {
    final dynamic data = appConfig[key];
    if (data != null && value.runtimeType != data.runtimeType) {
      throw ("The persistent type of ${data.runtimeType} does not match the given type ${value.runtimeType}");
    }
    appConfig.update(key, (dynamic) => value);
  }

  static void add(String key, dynamic value) {
    appConfig.putIfAbsent(key, () => value);
  }

  static void remove(String key) {
    appConfig.remove(key);
  }

  static void removeAll(List<String> keys) {
    for (final String key in keys) {
      appConfig.remove(key);
    }
  }

  static void save(String key, dynamic value) {
    if (appConfig.containsKey(key)) {
      update(key, value);
    } else {
      add(key, value);
    }
  }
}
