import 'package:flutter_cnblog/common/parser/category_parser.dart';
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
    final Element titleElement = element.getElementsByClassName("post-item-title")[0];

    final String postDate = metaElements[0].children.last.firstChild.toString().trimQuotation();
    final String diggCount = metaElements[1].children.last.firstChild.toString().trimQuotation();
    final String commentCount = metaElements[2].children.last.firstChild.toString().trimQuotation();
    final String viewCount = metaElements[3].children.last.firstChild.toString().trimQuotation();
    return BlogResp(
      id: int.parse(element.attributes['data-post-id']!),
      title: titleElement.firstChild.toString().trimQuotation(),
      url: titleElement.attributes['href']!,
      description: element.getElementsByClassName("post-item-summary").last.nodes.last.toString().trimQuotation().trim(),
      author: element.getElementsByClassName("post-item-author").last.firstChild!.firstChild!.toString().trimQuotation(),
      blogApp: element.getElementsByClassName("post-item-author").last.firstChild!.firstChild!.toString(),
      avatar: avatarElement.isEmpty ? '' : avatarElement[0].attributes['src'] ?? '',
      postDate: DateTime.parse(postDate),
      viewCount: int.parse(viewCount),
      commentCount: int.parse(commentCount),
      diggCount: int.parse(diggCount),
    );
  }
}
