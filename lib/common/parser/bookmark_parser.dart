import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:app_common_flutter/extension.dart';
import 'package:flutter_cnblog/model/bookmark.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:intl/intl.dart';

class BookmarkParser {
  static List<BookmarkInfo> parseBookmarkList(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByClassName("list_block");

    return elements.map((e) => _parseBookmark(e)).toList();
  }

  static BookmarkInfo _parseBookmark(Element element) {
    final Element titleElement = element.getElementsByTagName("a").firstWhere((element) => element.attributes['rel']! == "nofollow");
    final Element bodyElement = element.getFirstByClass("link_memo");

    return BookmarkInfo(
      id: element.attributes["id"]!.replaceFirst("link_", "").toInt(),
      title: titleElement.content,
      url: titleElement.attributes['href']!,
      starCounts: bodyElement.getFirstByClass("wz_item_count").intContent,
      postDate: DateFormat("MM/dd/yyyy hh:mm:ss").parse((bodyElement.getFirstByClass("date").attributes['title']!)),
    );
  }

  static bool isMark(String string) {
    return parse(string).getElementById("panel_add") == null;
  }
}
