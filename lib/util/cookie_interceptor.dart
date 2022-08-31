import 'package:dio/dio.dart';
import 'package:flutter_cnblog/common/constant/constant.dart';
import 'package:flutter_cnblog/util/prefs_util.dart';

class CookieInterceptor extends QueuedInterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers["Cookie"] = "${Constant.authCookieName}=${PrefsUtil.getCookie()};${PrefsUtil.getForgeryCookie()};";
    options.headers["x-requested-with"] = "XMLHttpRequest";
    handler.next(options);
  }
}
