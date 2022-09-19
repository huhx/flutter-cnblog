import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/model/instant_comment.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class InstantCommentParser {
  static List<InstantComment> parseInstantCommentList(String string) {
    final Document document = parse(string);
    final Element rootElement = document.getElementsByClassName("comment_list_block")[0];
    final Element ulElement = rootElement.getFirstByTag("ul");
    final int instantId = ulElement.attributes['id']!.replaceFirst("comment_block_", "").toInt();

    final List<Element> elements = ulElement.getElementsByTagName("li");

    return elements.map((e) => _parseInstantComment(e,instantId)).toList();
  }

  static InstantComment _parseInstantComment(Element element, int id) {
    final Element avatarElement = element.getFirstByTag("img");
    final int replyId = element.id.replaceFirst("comment_", "").toInt();

    final Element contentElement = element.getFirstByTag("bdo");
    String? fromName, fromUrl;
    final List<Element> fromElements = contentElement.getElementsByTagName("a");
    if (fromElements.isNotEmpty) {
      fromName = fromElements[0].getText();
      fromUrl = fromElements[0].attributes["href"];
    }

    final Element timeElement = element.getFirstByClass("text_green");
    final Element toElement = element.getElementsByTagName("a")[1];

    return InstantComment(
      id: id,
      replyId: replyId,
      fromName: fromName?.substring(1),
      fromUrl: fromUrl,
      toName: toElement.getText(),
      toUrl: "https:${toElement.attributes['href']}",
      avatar: avatarElement.attributes["src"]!,
      content: contentElement.innerHtml,
      postDate: timeElement.attributes["title"]!,
    );
  }
}
