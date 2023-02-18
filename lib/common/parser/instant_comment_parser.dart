import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:app_common_flutter/extension.dart';
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

    return elements.map((e) => _parseInstantComment(e, instantId)).toList();
  }

  static InstantComment _parseInstantComment(Element element, int replyId) {
    final Element contentElement = element.getFirstByTag("bdo");

    final Element? fromElement = contentElement.getFirstOrNullByTag("a");
    final String? fromName = fromElement?.content;
    final String? fromUrl = fromElement?.attributes["href"];

    final Element timeElement = element.getFirstByClass("text_green");
    final Element toElement = element.getElementsByTagName("a")[1];
    final String avatarUrl = element.getFirstByTag("img").attributes["src"]!;

    return InstantComment(
      id: element.id.replaceFirst("comment_", "").toInt(),
      replyId: replyId,
      fromName: fromName?.substring(1),
      fromUrl: fromUrl,
      toName: toElement.content,
      toUrl: "https:${toElement.attributes['href']}",
      avatar: avatarUrl.startsWith("http") ? avatarUrl : "https:$avatarUrl",
      content: contentElement.innerHtml,
      postDate: timeElement.attributes["title"]!,
    );
  }
}
