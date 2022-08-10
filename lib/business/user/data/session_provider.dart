import 'package:dio/dio.dart';
import 'package:flutter_cnblog/main.dart';
import 'package:flutter_cnblog/model/access_token.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    final Response<dynamic> response = await Dio().post(
      "https://oauth.cnblogs.com/connect/token",
      data: {
        "client_id": dotenv.env['clientId'],
        "client_secret": dotenv.env['clientSecret'],
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': 'https://oauth.cnblogs.com/auth/callback'
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    final AccessToken accessToken = AccessToken.fromJson(response.data);
    final String userToken = '${accessToken.tokenType} ${accessToken.accessToken}';
    logger.d("用户Token: $userToken");

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
