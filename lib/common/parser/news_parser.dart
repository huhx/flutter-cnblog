import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
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
    final Element titleElement = element.getFirstByClass("news_entry");
    final Element diggElement = element.getFirstByClass("diggnum");
    final Element summaryElement = element.getFirstByClass("entry_summary");
    final Element footerElement = element.getFirstByClass("entry_footer");

    final RegExp viewRegex = RegExp(r"([0-9]+) 人浏览");
    final String viewString = viewRegex.firstMatch(footerElement.outerHtml)!.group(1)!;

    final RegExp commentRegex = RegExp(r"评论\(([0-9]+)\)");
    final String commentString = commentRegex.firstMatch(footerElement.outerHtml)!.group(1)!;

    final String dateString = footerElement.getLastChildText();
    final List<Element> coverElements = summaryElement.getElementsByClassName("topic_img");

    return NewsInfo(
      id: element.attributes["id"]!.replaceFirst("entry_", "").toInt(),
      title: titleElement.getFirstChildText(),
      url: titleElement.children.first.attributes['href']!,
      summary: summaryElement.getLastNodeText(),
      cover: coverElements.isEmpty ? '' : coverElements.first.attributes['src']!,
      homeUrl: "https:${footerElement.getFirstByTag("a").attributes['href']!}",
      submitter: footerElement.getFirstByTag("a").getText().trim(),
      commentCount: commentString.toInt(),
      diggCount: diggElement.getText().toInt(),
      viewCount: viewString.toInt(),
      postDate: DateTime.parse(dateString),
    );
  }
}