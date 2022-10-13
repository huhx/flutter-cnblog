import 'package:flutter_cnblog/api/token_api.dart';
import 'package:flutter_cnblog/api/user_api.dart';
import 'package:flutter_cnblog/main.dart';
import 'package:flutter_cnblog/model/access_token.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_cnblog/util/prefs_util.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sessionProvider = StateNotifierProvider<SessionModel, User?>((ref) {
  final User? user = PrefsUtil.getUser();
  return SessionModel(user);
});

class SessionModel extends StateNotifier<User?> {
  SessionModel(User? user) : super(user);

  String get userId => state!.userId;

  String get displayName => state!.displayName;

  bool get isAuth => state != null;

  Future<void> login(String code) async {
    final AccessToken accessToken = await tokenApi.getUserToken(code);
    logger.d("用户Token: ${accessToken.accessToken}");
    AppConfig.save("user_token", accessToken);

    final User user = await userApi.currentUser();
    state = user;

    logger.d("user = ${user.displayName}");
    await PrefsUtil.saveUser(user);
    AppConfig.save("user", user);
    AppConfig.save("userId", user.userId);
  }

  Future<void> logout() async {
    await CookieManager.instance().deleteAllCookies();

    state = null;

    PrefsUtil.logout();
    AppConfig.remove("user");
    AppConfig.remove("userId");
    AppConfig.remove("cookie");
  }
}
