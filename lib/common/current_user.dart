import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/util/app_config.dart';

class CurrentUser {
  static int getUserId() {
    return AppConfig.getInt("userId");
  }

  static User getUser() {
    return AppConfig.get("user");
  }
}
