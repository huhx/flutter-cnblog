import 'package:html/dom.dart';
import 'package:html/parser.dart';

import 'html_css.dart';

class HtmlCssInjector {
  static String inject(HtmlCss htmlCss) {
    final Document document = parse(htmlCss.html);
    final Element headElement = document.getElementsByTagName("head")[0];

    // set host in css url
    headElement.getElementsByTagName("link").forEach((element) {
      final String? cssUrl = element.attributes['href'];
      if (cssUrl != null && cssUrl.startsWith("/")) {
        element.attributes['href'] = "${htmlCss.host}$cssUrl";
      }
    });

    // set host in js url
    headElement.getElementsByTagName("script").forEach((element) {
      final String? jsUrl = element.attributes['src'];
      if (jsUrl != null && jsUrl.startsWith("/")) {
        element.attributes['src'] = "${htmlCss.host}$jsUrl";
      }
    });

    // inject css
    final Element cssElement = Element.tag("style");
    cssElement.innerHtml = htmlCss.css;
    headElement.nodes.insert(0, cssElement);

    return document.outerHtml;
  }
}
