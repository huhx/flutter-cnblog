import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/support/html_css.dart';
import 'package:flutter_cnblog/common/support/html_css_injector.dart';
import 'package:flutter_cnblog/util/dio_util.dart';

class HtmlCssApi {
  Future<String> injectCss(String url, String css, String host) async {
    final Response response = await RestClient.withCookie().get(url);

    return compute(HtmlCssInjector.inject, HtmlCss(html: response.data as String, css: css, host: host));
  }
}

final htmlCssApi = HtmlCssApi();
