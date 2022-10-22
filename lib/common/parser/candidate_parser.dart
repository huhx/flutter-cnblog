import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/common/support/comm_parser.dart';
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
    final String avatar = element.getFirstOrNullByClass("avatar")?.attributes['src'] ?? '';
    final List<Element> metaElements = element.getElementsByClassName("post-meta-item");
    final Element titleElement = element.getFirstByClass("post-item-title");

    final String postDate = metaElements[0].lastChildText;
    final String diggCount = metaElements[1].lastChildText;
    final String commentCount = metaElements[2].lastChildText;
    final String viewCount = metaElements[3].lastChildText;
    final String url = titleElement.getAttributeValue('href')!;

    return BlogResp(
      id: element.getAttributeValue("data-post-id")!.toInt(),
      title: titleElement.content,
      url: titleElement.getAttributeValue('href')!,
      description: element.getFirstByClass("post-item-summary").lastNodeText,
      author: element.getFirstByClass("post-item-author").firstChildText,
      blogApp: Comm.getNameFromBlogUrl(url),
      avatar: avatar,
      postDate: DateTime.parse(postDate),
      viewCount: viewCount.toInt(),
      commentCount: commentCount.toInt(),
      diggCount: diggCount.toInt(),
    );
  }
}
