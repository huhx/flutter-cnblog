import 'package:flutter_cnblog/common/parser/category_parser.dart';
import 'package:flutter_cnblog/model/news.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class NewsParser {
  static List<NewsInfo> parseNewsList(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByClassName("news_block");

    return elements.map((e) => _parseNews(e)).toList();
  }

  static NewsInfo _parseNews(Element element) {
    final Element titleElement = element.getElementsByTagName("a")[1];
    final Element diggElement = element.getElementsByClassName("diggnum")[0];
    final Element summaryElement = element.getElementsByClassName("entry_summary")[0];
    final Element footerElement = element.getElementsByClassName("entry_footer")[0];

    final RegExp viewRegex = RegExp(r"([0-9]+) 人浏览");
    final String viewString = viewRegex.firstMatch(footerElement.outerHtml)!.group(1)!;

    final RegExp commentRegex = RegExp(r"评论\(([0-9]+)\)");
    final String commentString = commentRegex.firstMatch(footerElement.outerHtml)!.group(1)!;

    final String dateString = footerElement.children.last.firstChild.toString().trimQuotation();

    return NewsInfo(
      id: int.parse(element.attributes["id"]!.replaceFirst("entry_", "")),
      title: element.getElementsByTagName("a")[0].nodes.last.toString().trimQuotation().trim(),
      url: titleElement.attributes['href']!,
      summary: summaryElement.nodes.last.toString().trimQuotation().trim(),
      cover: summaryElement.getElementsByTagName("img").isEmpty ? '': summaryElement.getElementsByTagName("img")[0].attributes['src']!,
      homeUrl: "https:${footerElement.getElementsByTagName("a")[0].attributes['href']!}",
      submitter: footerElement.getElementsByTagName("a")[0].firstChild.toString().trimQuotation().trim(),
      commentCount: int.parse(commentString),
      diggCount: int.parse(diggElement.firstChild.toString().trimQuotation()),
      viewCount: int.parse(viewString),
      pastDate: DateTime.parse(dateString),
    );
  }
}