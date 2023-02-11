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

    final String viewString = footerElement.getRegexText(r"([0-9]+) 人浏览");
    final String commentString = footerElement.getRegexText(r"评论\(([0-9]+)\)");

    final String dateString = footerElement.lastChildText;
    final String coverString = summaryElement.getFirstOrNullByClass("topic_img")?.attributes['src'] ?? '';

    return NewsInfo(
      id: element.attributes["id"]!.replaceFirst("entry_", "").toInt(),
      title: titleElement.firstChildText,
      url: titleElement.children.first.attributes['href']!,
      summary: summaryElement.lastNodeText,
      cover: coverString,
      homeUrl: "https:${footerElement.getFirstByTag("a").attributes['href']!}",
      submitter: footerElement.getFirstByTag("a").content.trim(),
      commentCount: commentString.toInt(),
      diggCount: diggElement.intContent,
      viewCount: viewString.toInt(),
      postDate: DateTime.parse(dateString),
    );
  }
}
