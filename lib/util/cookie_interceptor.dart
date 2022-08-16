import 'package:dio/dio.dart';

import 'app_config.dart';

class CookieInterceptor extends QueuedInterceptorsWrapper {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers["Cookie"] = ".Cnblogs.AspNetCore.Cookies=${AppConfig.get("cookie")}";
    options.headers["x-requested-with"] = "XMLHttpRequest";
    handler.next(options);
  }
}
