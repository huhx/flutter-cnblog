import 'package:flutter_cnblog/common/support/html_css.dart';
import 'package:flutter_cnblog/common/support/html_css_injector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return html with css injection", () {
    const String html = r'''
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <link id="favicon" rel="shortcut icon" href="//common.cnblogs.com/favicon.svg" type="image/svg+xml">
    <link rel="stylesheet" href="/css/blog-common.min.css?v=x0sCXgfRZH24nF9pqBIDTBIzbO5BqnCcmdVV58d1xnI">
    
    <script src="https://common.cnblogs.com/scripts/jquery-2.2.0.min.js"></script>
    <script src="/js/blog-common.min.js?v=CJqpEcB2VzA38UjNF1IXe3fHW_bnz9JDDOND4We0ej8"></script>
</head>
<body class="skin-darkgreentrip no-navbar mathjax2"><div>Hello World</div></body></html>''';

    const String css = '''
      .postDesc {display: none;}   
      #comment_form {display: none;}    
    ''';

    const HtmlCss htmlCss = HtmlCss(html: html, css: css, host: "https://www.cnblogs.com");
    final String htmlContent = HtmlCssInjector.inject(htmlCss);

    expect(
      htmlContent,
      '''
<!DOCTYPE html><html lang="zh-cn"><head><style>      .postDesc {display: none;}   
      #comment_form {display: none;}    
    </style>
    <meta charset="utf-8">
    <link id="favicon" rel="shortcut icon" href="https://www.cnblogs.com//common.cnblogs.com/favicon.svg" type="image/svg+xml">
    <link rel="stylesheet" href="https://www.cnblogs.com/css/blog-common.min.css?v=x0sCXgfRZH24nF9pqBIDTBIzbO5BqnCcmdVV58d1xnI">
    
    <script src="https://common.cnblogs.com/scripts/jquery-2.2.0.min.js"></script>
    <script src="https://www.cnblogs.com/js/blog-common.min.js?v=CJqpEcB2VzA38UjNF1IXe3fHW_bnz9JDDOND4We0ej8"></script>
</head>
<body class="skin-darkgreentrip no-navbar mathjax2"><div>Hello World</div></body></html>''',
    );
  });
}
