import 'package:app_common_flutter/util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cnblog/api/token_api.dart';
import 'package:flutter_cnblog/common/constant/token_type.dart';
import 'package:flutter_cnblog/model/access_token.dart';

class AuthorizationInterceptor extends QueuedInterceptorsWrapper {
  final TokenType tokenType;

  AuthorizationInterceptor({required this.tokenType});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (tokenType == TokenType.none) {
      handler.next(options);
      return;
    }

    AccessToken? accessToken = getToken(tokenType);
    if (accessToken == null) {
      if (tokenType == TokenType.user) {
        return handler.reject(DioException(requestOptions: options));
      } else {
        accessToken = await tokenApi.getToken();
      }
    }

    options.headers["Authorization"] = "Bearer ${accessToken.accessToken}";
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (tokenType == TokenType.user) {
        handler.reject(err);
        return;
      }
      final AccessToken accessToken = await tokenApi.getToken();
      final RequestOptions requestOptions = err.requestOptions;
      requestOptions.headers["Authorization"] = "Bearer ${accessToken.accessToken}";

      await Dio().request(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: Options(method: requestOptions.method, headers: requestOptions.headers),
      );
    } else {
      handler.reject(err);
    }
  }

  AccessToken? getToken(TokenType tokenType) {
    if (tokenType == TokenType.app) {
      return AppConfig.get("access_token");
    }
    return AppConfig.get("user_token");
  }
}
