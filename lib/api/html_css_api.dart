import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/constant/content_type.dart';
import 'package:flutter_cnblog/common/support/html_css.dart';
import 'package:flutter_cnblog/common/support/html_css_injector.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_cnblog/util/dio_util.dart';
import 'package:flutter_cnblog/util/prefs_util.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class HtmlCssApi {
  Future<String> injectCss(String url, ContentType type) async {
    final Response response = await RestClient.withCookie().get(url);
    final HtmlCss htmlCss = HtmlCss(html: response.data as String, host: type.host, css: AppConfig.get(type.css));

    if (type == ContentType.blog) {
      await PrefsUtil.saveForgeryCookie(response.headers['set-cookie']?.first ?? "");

      final Document document = parse(htmlCss.html);
      final String? forgeryToken = document.getElementById("antiforgery_token")?.attributes['value']!;
      await PrefsUtil.saveForgeryToken(forgeryToken);
    }

    return compute(HtmlCssInjector.inject, htmlCss);
  }
}

final htmlCssApi = HtmlCssApi();
