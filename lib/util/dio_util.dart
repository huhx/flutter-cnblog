import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter_cnblog/common/constant/token_type.dart';
import 'package:flutter_cnblog/util/cookie_interceptor.dart';

import 'authorization_interceptor.dart';

class RestClient {
  static Dio getInstance({TokenType tokenType = TokenType.app}) {
    return Dio(BaseOptions())
      ..interceptors.add(HttpFormatter())
      ..interceptors.add(AuthorizationInterceptor(tokenType: tokenType));
  }

  static Dio withCookie() {
    return Dio(BaseOptions())
      ..interceptors.add(HttpFormatter())
      ..interceptors.add(CookieInterceptor());
  }
}
