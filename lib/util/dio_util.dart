import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';

class RestClient {
  static Dio getInstance() {
    final Dio dio = Dio(BaseOptions());
    dio.interceptors.add(HttpFormatter());
    return dio;
  }
}
