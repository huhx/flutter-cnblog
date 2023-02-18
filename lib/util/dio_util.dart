import 'package:dio/dio.dart';
import 'package:flutter_cnblog/common/constant/token_type.dart';
import 'package:flutter_cnblog/util/cookie_interceptor.dart';

import 'authorization_interceptor.dart';

class RestClient {
  static Dio getInstance({TokenType tokenType = TokenType.app}) {
    return Dio(BaseOptions())
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true))
      ..interceptors.add(AuthorizationInterceptor(tokenType: tokenType));
  }

  static Dio withCookie() {
    return Dio(BaseOptions())
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true))
      ..interceptors.add(CookieInterceptor());
  }
}
