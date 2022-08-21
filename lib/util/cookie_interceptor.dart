import 'package:dio/dio.dart';
import 'package:flutter_cnblog/common/constant/constant.dart';

import 'app_config.dart';

class CookieInterceptor extends QueuedInterceptorsWrapper {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers["Cookie"] = "${Constant.authCookieName}=${AppConfig.get("cookie")}";
    options.headers["x-requested-with"] = "XMLHttpRequest";
    handler.next(options);
  }
}
