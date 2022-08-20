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

    final String commentString = element.getFirstByClass("searchItemInfo-comments").getText();
    final String commentCountString = commentString.replaceFirstMapped(RegExp(r"评论\(([0-9]+)\)"), (match) => match.group(1)!);

    return SearchInfo(
      title: element.getFirstByClass("searchItemTitle").getFirstChildText(),
      url: urlString,
      summary: element.getFirstByClass("searchCon").outerHtml,
      viewCount: int.parse(viewCountString),
      commentCount: int.parse(commentCountString),
      postDate: element.getFirstByClass("searchItemInfo-publishDate").getText(),
    );
  }
}
