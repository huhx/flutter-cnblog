import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/model/message.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class MessageParser {
  static List<MessageInfo> parseMessageList(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByTagName("tbody")[0].getElementsByTagName("tr");

    return elements.map((e) => _parseMessage(e)).toList();
  }

  static MessageInfo _parseMessage(Element element) {
    final List<Element> textElements = element.getElementsByClassName("text_overflow_ellipsis");
    final Element authorElement = textElements[0];
    final Element titleElement = textElements[1].getFirstByTag("a");

    String? homeUrl;
    String author;
    if (authorElement.getElementsByTagName("a").isEmpty) {
      author = authorElement.content;
    } else {
      final Element element = authorElement.getFirstByTag("a");
      homeUrl = "https:${element.attributes["href"]}";
      author = element.content;
    }

    return MessageInfo(
      id: element.attributes["id"]!.replaceFirst("msg_item_", "").toInt(),
      homeUrl: homeUrl,
      title: titleElement.innerHtml.trim(),
      url: "https://msg.cnblogs.com${titleElement.attributes['href']}",
      postDate: textElements[1].nextElementSibling!.content,
      author: author.trim(),
      status: authorElement.previousElementSibling?.content,
    );
  }
}
