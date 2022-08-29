import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class SearchParser {
  static List<SearchInfo> parseSearchList(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByClassName("searchItem");

    return elements.map((e) => _parseSearchInfo(e)).toList();
  }

  static SearchInfo _parseSearchInfo(Element element) {
    final String urlString = element.getFirstByClass("searchURL").getText().trim();

    int? viewCount;
    final List<Element> viewElements = element.getElementsByClassName("searchItemInfo-views");
    if (viewElements.isNotEmpty) {
      final String viewString = viewElements[0].getText();
      viewCount = viewString.replaceFirstMapped(RegExp(r"浏览\(([0-9]+)\)"), (match) => match.group(1)!).toInt();
    }

    int? commentCount;
    final List<Element> commentElements = element.getElementsByClassName("searchItemInfo-comments");
    if (commentElements.isNotEmpty) {
      final String commentString = commentElements[0].getText();
      commentCount = commentString.replaceFirstMapped(RegExp(r"评论\(([0-9]+)\)"), (match) => match.group(1)!).toInt();
    }

    String? author, homeUrl;
    final Element usernameElement = element.getFirstByClass("searchItemInfo-userName");
    if (usernameElement.children.isNotEmpty) {
      author = usernameElement.getFirstChildText();
      homeUrl = usernameElement.children[0].attributes["href"];
    }

    int? diggCount;
    final List<Element> diggElements = element.getElementsByClassName("searchItemInfo-good");
    if (diggElements.isNotEmpty) {
      final String diggString = diggElements[0].getText();
      diggCount = diggString.replaceFirstMapped(RegExp(r"推荐\(([0-9]+)\)"), (match) => match.group(1)!).toInt();
    }

    return SearchInfo(
      title: element.getFirstByClass("searchItemTitle").children.first.innerHtml,
      url: urlString,
      summary: element.getFirstByClass("searchCon").outerHtml,
      author: author,
      homeUrl: homeUrl,
      viewCount: viewCount,
      commentCount: commentCount,
      diggCount: diggCount,
      postDate: element.getFirstByClass("searchItemInfo-publishDate").getText(),
    );
  }
}
