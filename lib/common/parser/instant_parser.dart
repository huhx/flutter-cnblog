import 'package:flutter_cnblog/common/parser/category_parser.dart';
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
    final Element avatarElement = element.getElementsByTagName("img")[0];
    final Element bodyElement = element.getElementsByClassName("feed_body")[0];
    final Element contentElement = bodyElement.getElementsByClassName("ing_body")[0];
    final Element urlElement = bodyElement.getElementsByClassName("ing_time")[0];
    final Element authorElement = bodyElement.getElementsByClassName("ing-author")[0];
    final Element commentElement = bodyElement.getElementsByClassName("ing_reply")[0];

    final RegExp commentsRegex = RegExp(r"([0-9]+)回应");
    final String commentCountString = commentsRegex.firstMatch(commentElement.outerHtml) == null ? "0": commentsRegex.firstMatch(commentElement.outerHtml)!.group(1)!;

    return InstantInfo(
      id: int.parse(bodyElement.attributes['id']!.replaceFirst("feed_content_", "")),
      content: contentElement.firstChild.toString().trimQuotation(),
      url: urlElement.attributes['href']!,
      submitter: authorElement.firstChild.toString().trimQuotation().trim(),
      avatar: avatarElement.attributes['src']!,
      homeUrl: "https:${authorElement.attributes['href']}",
      postDate: urlElement.nodes.first.toString().toString().trimQuotation().trim(),
      commentCounts: int.parse(commentCountString),
      comments: [],
    );
  }
}