import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/util/prefs_util.dart';

class CurrentUser {
  static User getUser() {
    return PrefsUtil.getUser()!;
  }
}
