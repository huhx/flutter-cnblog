import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';

import 'authorization_interceptor.dart';

class RestClient {
  static Dio getInstance() {
    final Dio dio = Dio(BaseOptions());
    dio.interceptors.add(HttpFormatter());
    dio.interceptors.add(AuthorizationInterceptor());
    return dio;
  }
}
