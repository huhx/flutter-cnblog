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

    int? viewCount = element.getFirstOrNullByClass("searchItemInfo-views")?.getRegexText(r"浏览\(([0-9]+)\)").toInt();
    int? commentCount = element.getFirstOrNullByClass("searchItemInfo-comments")?.getRegexText(r"评论\(([0-9]+)\)").toInt();
    int? diggCount = element.getFirstOrNullByClass("searchItemInfo-good")?.getRegexText(r"推荐\(([0-9]+)\)").toInt();

    String? author, homeUrl;
    final Element usernameElement = element.getFirstByClass("searchItemInfo-userName");
    if (usernameElement.children.isNotEmpty) {
      author = usernameElement.getFirstChildText();
      homeUrl = usernameElement.children[0].attributes["href"];
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
