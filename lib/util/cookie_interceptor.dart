import 'package:dio/dio.dart';
import 'package:flutter_cnblog/common/constant/constant.dart';
import 'package:flutter_cnblog/util/prefs_util.dart';

class CookieInterceptor extends QueuedInterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final String? forgeryCookie = PrefsUtil.getForgeryCookie();

    options.headers["Cookie"] = "${Constant.authCookieName}=${PrefsUtil.getCookie()};$forgeryCookie;";
    options.headers["x-requested-with"] = "XMLHttpRequest";

    handler.next(options);
  }
}
