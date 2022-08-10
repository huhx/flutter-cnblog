import 'package:dio/dio.dart';
import 'package:flutter_cnblog/api/token_api.dart';
import 'package:flutter_cnblog/model/access_token.dart';

class AuthorizationInterceptor extends QueuedInterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final AccessToken accessToken = await tokenApi.getToken();
    options.headers["Authorization"] = "Bearer ${accessToken.accessToken}";
    handler.next(options);
  }
}
