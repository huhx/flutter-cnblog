import 'package:flutter_cnblog/common/extension/element_extension.dart';
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
    final String viewString = element.getFirstByClass("searchItemInfo-views").getText();
    final String viewCountString = viewString.replaceFirstMapped(RegExp(r"浏览\(([0-9]+)\)"), (match) => match.group(1)!);

    int? commentCount;
    final List<Element> commentElements = element.getElementsByClassName("searchItemInfo-comments");
    if (commentElements.isNotEmpty) {
      final String commentString = commentElements[0].getText();
      commentCount = int.parse(commentString.replaceFirstMapped(RegExp(r"评论\(([0-9]+)\)"), (match) => match.group(1)!));
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
      diggCount = int.parse(diggString.replaceFirstMapped(RegExp(r"推荐\(([0-9]+)\)"), (match) => match.group(1)!));
    }

    return SearchInfo(
      title: element.getFirstByClass("searchItemTitle").children.first.innerHtml,
      url: urlString,
      summary: element.getFirstByClass("searchCon").outerHtml,
      author: author,
      homeUrl: homeUrl,
      viewCount: int.parse(viewCountString),
      commentCount: commentCount,
      diggCount: diggCount,
      postDate: element.getFirstByClass("searchItemInfo-publishDate").getText(),
    );
  }
}
