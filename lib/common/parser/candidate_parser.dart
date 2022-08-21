import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class CandidateParser {
  static List<BlogResp> parseCandidateList(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByClassName("post-item");
    return elements.map((e) => _parseCandidate(e)).toList();
  }

  static BlogResp _parseCandidate(Element element) {
    final List<Element> avatarElement = element.getElementsByClassName("avatar");
    final List<Element> metaElements = element.getElementsByClassName("post-meta-item");
    final Element titleElement = element.getFirstByClass("post-item-title");

    final String postDate = metaElements[0].getLastChildText();
    final String diggCount = metaElements[1].getLastChildText();
    final String commentCount = metaElements[2].getLastChildText();
    final String viewCount = metaElements[3].getLastChildText();

    return BlogResp(
      id: element.getAttributeValue("data-post-id")!.toInt(),
      title: titleElement.getText(),
      url: titleElement.getAttributeValue('href')!,
      description: element.getFirstByClass("post-item-summary").getLastNodeText(),
      author: element.getFirstByClass("post-item-author").getFirstChildText(),
      blogApp: element.getFirstByClass("post-item-author").getFirstChildText(),
      avatar: avatarElement.isEmpty ? '' : avatarElement[0].attributes['src'] ?? '',
      postDate: DateTime.parse(postDate),
      viewCount: viewCount.toInt(),
      commentCount: commentCount.toInt(),
      diggCount: diggCount.toInt(),
    );
  }
}
