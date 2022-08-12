import 'package:dio/dio.dart';
import 'package:flutter_cnblog/api/token_api.dart';
import 'package:flutter_cnblog/main.dart';
import 'package:flutter_cnblog/model/access_token.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sessionProvider = StateNotifierProvider<SessionModel, User?>((ref) {
  return SessionModel();
});

class SessionModel extends StateNotifier<User?> {
  SessionModel() : super(null);

  String get userId => state!.userId;

  String get displayName => state!.displayName;

  bool get isAuth => state != null;

  Future<void> login(String code) async {
    final AccessToken accessToken = await tokenApi.getUserToken(code);
    final String userToken = '${accessToken.tokenType} ${accessToken.accessToken}';

    final Response userResponse = await Dio().get(
      "https://api.cnblogs.com/api/users",
      options: Options(headers: {"Authorization": userToken}),
    );
    if (userResponse.data != null) {
      final User user = User.fromJson(userResponse.data);
      logger.d("user = ${user.displayName}");
      AppConfig.save("user", user);
      AppConfig.save("token", userToken);
      AppConfig.save("userId", user.userId);

      state = user;
    }
  }
}
