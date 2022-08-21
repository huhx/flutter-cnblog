import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
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

    final Element summaryElement = element.getFirstByClass("msg_summary");
    final Element footerElement = element.getFirstByClass("msg_tag");

    final RegExp viewRegex = RegExp(r"阅读\(([0-9]+)\)");
    final String viewString = footerElement.getFirstByClass("view").getText();
    final String viewCount = viewRegex.firstMatch(viewString)!.group(1)!;

    final RegExp diggRegex = RegExp(r"推荐\(([0-9]+)\)");
    final String diggString = footerElement.getFirstByClass("recommend").getText();
    final String diggCount = diggRegex.firstMatch(diggString)!.group(1)!;

    final List<String> tags = footerElement.getFirstByClass("tag").getElementsByClassName("catalink").map((e) => e.getText()).toList();

    return KnowledgeInfo(
      id: url.split("/")[2].toInt(),
      title: titleElement.getText(),
      url: "https://kb.cnblogs.com$url",
      summary: summaryElement.getFirstChildText(),
      category: categoryElement.getText(),
      tags: tags,
      postDate: DateTime.parse(footerElement.getLastChildText()),
      viewCount: viewCount.toInt(),
      diggCount: diggCount.toInt(),
    );
  }
}
