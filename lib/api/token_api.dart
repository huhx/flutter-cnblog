import 'package:dio/dio.dart';
import 'package:flutter_cnblog/model/access_token.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TokenApi {
  Future<AccessToken> getToken() async {
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

  Future<AccessToken> getUserToken(String code) async {
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
    return AccessToken.fromJson(response.data);
  }
}

final tokenApi = TokenApi();
