import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/model/instant_comment.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class InstantCommentParser {
  static List<InstantComment> parseInstantCommentList(String string) {
    final Document document = parse(string);
    final List<Element> elements =
        document.getElementsByTagName("li").where((element) => element.attributes['id']?.startsWith("comment") ?? false).toList();

    return elements.map((e) => _parseInstantComment(e)).toList();
  }

  static InstantComment _parseInstantComment(Element element) {
    final Element idElements = element.getFirstByTag("a");
    final List<String> idStrings =
        idElements.attributes["onclick"]!.split(";")[0].replaceFirst("commentReply(", "").replaceFirst(")", "").split(", ");

    final Element contentElement = element.getFirstByTag("span");
    String? fromName, fromUrl;
    final List<Element> fromElements = contentElement.getElementsByTagName("a");
    if (fromElements.isNotEmpty) {
      fromName = fromElements[0].getText();
      fromUrl = fromElements[0].attributes["href"];
    }

    final Element timeElement = element.getFirstByClass("ing_comment_time");
    final Element toElement = element.getElementsByTagName("a")[1];

    return InstantComment(
      id: idStrings[0].toInt(),
      replyId: idStrings[1].toInt(),
      paneId: idStrings[2].toInt(),
      fromName: fromName?.substring(1),
      fromUrl: fromUrl,
      toName: toElement.getText(),
      toUrl: toElement.attributes['href']!,
      content: contentElement.getLastNodeText(),
      postDate: timeElement.getText(),
    );
  }
}
