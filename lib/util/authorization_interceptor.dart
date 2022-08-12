import 'package:dio/dio.dart';
import 'package:flutter_cnblog/api/token_api.dart';
import 'package:flutter_cnblog/common/constant/token_type.dart';
import 'package:flutter_cnblog/model/access_token.dart';

import 'app_config.dart';

class AuthorizationInterceptor extends QueuedInterceptorsWrapper {
  final TokenType tokenType;

  AuthorizationInterceptor({required this.tokenType});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    late AccessToken accessToken;
    if (tokenType == TokenType.app) {
      accessToken = await tokenApi.getToken();
    } else {
      accessToken = AppConfig.get("user_token");
    }
    options.headers["Authorization"] = "Bearer ${accessToken.accessToken}";
    handler.next(options);
  }
}
