import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter_cnblog/common/constant/token_type.dart';

import 'authorization_interceptor.dart';

class RestClient {
  static Dio getInstance({TokenType tokenType = TokenType.app}) {
    final Dio dio = Dio(BaseOptions());
    dio.interceptors.add(HttpFormatter());
    dio.interceptors.add(AuthorizationInterceptor(tokenType: tokenType));
    return dio;
  }
}
