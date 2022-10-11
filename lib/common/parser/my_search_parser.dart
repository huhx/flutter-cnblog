import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class MySearchParser {
  static List<SearchInfo> parseSearchList(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByClassName("result-item");

    return elements.map((e) => _parseSearchInfo(e)).toList();
  }

  static SearchInfo _parseSearchInfo(Element element) {
    final Element titleElement = element.getFirstByClass("result-title").children.first;
    final int viewCount = element.getFirstByClass("icon-liulan").getParentLastNodeText().toInt();
    final int? commentCount = element.getFirstOrNullByClass("icon-pinglun")?.getParentLastNodeText().toInt();
    final int? diggCount = element.getFirstOrNullByClass("icon-dianzan")?.getParentLastNodeText().toInt();

    return SearchInfo(
      title: titleElement.innerHtml.trim(),
      url: titleElement.attributes["href"]!,
      summary: element.getFirstByClass("result-content").outerHtml,
      viewCount: viewCount,
      commentCount: commentCount,
      diggCount: diggCount,
      postDate: element.getFirstByClass("result-widget").children.first.getLastNodeText(),
    );
  }
}
