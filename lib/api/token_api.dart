import 'package:dio/dio.dart';
import 'package:flutter_cnblog/model/access_token.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TokenApi {
  Future<AccessToken> getToken() async {
    if (AppConfig.get("access_token") != null) {
      return AppConfig.get("access_token");
    }
    final Response<dynamic> response = await Dio().post(
      "https://api.cnblogs.com/token",
      data: {
        "client_id": dotenv.env['clientId'],
        "client_secret": dotenv.env['clientSecret'],
        'grant_type': 'client_credentials',
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    final AccessToken accessToken = AccessToken.fromJson(response.data);
    AppConfig.save("access_token", accessToken);
    return accessToken;
  }
}

final tokenApi = TokenApi();
