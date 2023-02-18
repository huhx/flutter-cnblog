import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:app_common_flutter/extension.dart';
import 'package:flutter_cnblog/model/knowledge.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class KnowledgeParser {
  static List<KnowledgeInfo> parseKnowledgeList(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByClassName("aiticle_item");

    return elements.map((e) => _parseKnowledge(e)).toList();
  }

  static KnowledgeInfo _parseKnowledge(Element element) {
    final Element titleContainerElement = element.getFirstByClass("msg_title");
    final Element titleElement = titleContainerElement.getFirstByTag("a");
    final Element categoryElement = titleContainerElement.getFirstByClass("classify_name");
    final String url = titleElement.getAttributeValue("href")!;

    final Element footerElement = element.getFirstByClass("msg_tag");
    final String viewCount = footerElement.getFirstByClass("view").getRegexText(r"阅读\(([0-9]+)\)");
    final String diggCount = footerElement.getFirstByClass("recommend").getRegexText(r"推荐\(([0-9]+)\)");

    final List<String> tags = footerElement.getFirstByClass("tag").getElementsByClassName("catalink").map((e) => e.content).toList();

    return KnowledgeInfo(
      id: url.split("/")[2].toInt(),
      title: titleElement.content,
      url: "https://kb.cnblogs.com$url",
      summary: element.getFirstByClass("msg_summary").firstChildText,
      category: categoryElement.content,
      tags: tags,
      postDate: DateTime.parse(footerElement.lastChildText),
      viewCount: viewCount.toInt(),
      diggCount: diggCount.toInt(),
    );
  }
}
