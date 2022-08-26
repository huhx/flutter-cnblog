import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/constant/content_type.dart';
import 'package:flutter_cnblog/common/support/html_css.dart';
import 'package:flutter_cnblog/common/support/html_css_injector.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_cnblog/util/dio_util.dart';

class HtmlCssApi {
  Future<String> injectCss(String url, ContentType type) async {
    final Response response = await RestClient.withCookie().get(url);
    final HtmlCss htmlCss = HtmlCss(html: response.data as String, host: type.host, css: AppConfig.get(type.css));

    return compute(HtmlCssInjector.inject, htmlCss);
  }
}

final htmlCssApi = HtmlCssApi();
