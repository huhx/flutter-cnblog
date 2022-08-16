import 'package:flutter_cnblog/common/parser/category_parser.dart';
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
    final Element bodyElement = element.getElementsByClassName("link_memo")[0];

    return BookmarkInfo(
      id: int.parse(element.attributes["id"]!.replaceFirst("link_", "")),
      title: titleElement.firstChild.toString().trimQuotation().trim(),
      url: titleElement.attributes['href']!,
      starCounts: int.parse(bodyElement.getElementsByClassName("wz_item_count")[0].firstChild.toString().trimQuotation()),
      postDate: DateFormat("MM/dd/yyyy hh:mm:ss").parse((bodyElement.getElementsByClassName("date")[0].attributes['title']!)),
    );
  }
}