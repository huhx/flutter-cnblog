import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/model/instant.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class InstantParser {
  static List<InstantInfo> parseInstantList(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByClassName("ing-item");

    return elements.map((e) => _parseInstant(e)).toList();
  }

  static InstantInfo _parseInstant(Element element) {
    final Element avatarElement = element.getFirstByTag("img");
    final String avatarString = avatarElement.attributes['src']!;

    final Element bodyElement = element.getFirstByClass("feed_body");
    final Element contentElement = bodyElement.getFirstByClass("ing_body");
    final Element urlElement = bodyElement.getFirstByClass("ing_time");
    final Element authorElement = bodyElement.getFirstByClass("ing-author");
    final Element commentElement = bodyElement.getFirstByClass("ing_reply");

    final RegExp commentsRegex = RegExp(r"([0-9]+)回应");
    final RegExpMatch? firstMatch = commentsRegex.firstMatch(commentElement.outerHtml);
    final String commentCountString = firstMatch == null ? "0" : firstMatch.group(1)!;

    return InstantInfo(
      id: bodyElement.attributes['id']!.replaceFirst("feed_content_", "").toInt(),
      content: contentElement.outerHtml,
      url: "https://ing.cnblogs.com${urlElement.attributes['href']}",
      submitter: authorElement.getText(),
      avatar: avatarString.startsWith("http") ? avatarString : "https:$avatarString",
      homeUrl: "https:${authorElement.attributes['href']}",
      postDate: urlElement.getText(),
      commentCounts: commentCountString.toInt(),
      comments: const [],
    );
  }
}
