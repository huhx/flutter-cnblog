import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:app_common_flutter/extension.dart';
import 'package:flutter_cnblog/model/blog_category.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class CategoryParser {
  static List<CategoryList> parseCategoryList(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByTagName("ul");
    final List<Element> groupElements = elements.where((element) => element.attributes['class'] != null).toList();

    return groupElements.map((e) {
      final List<Element> elements = e.getElementsByTagName("a");
      final CategoryInfo group = _parseCategory(elements.first);
      final List<CategoryInfo> children = elements.sublist(1).map((e) => CategoryParser._parseCategory(e)).toList();
      return CategoryList(group: group, children: children);
    }).toList();
  }

  static List<BlogResp> parseCategory(String string) {
    final Document document = parse(string);
    final Element? rootElement = document.getElementById("post_list");
    if (rootElement == null) {
      return List.empty();
    }
    final List<Element> elements = rootElement.getElementsByTagName("article");
    return elements.map((e) => _parseIntoBlogResp(e)).toList();
  }

  static BlogResp _parseIntoBlogResp(Element element) {
    final String avatar = element.getFirstOrNullByClass("avatar")?.attributes['src'] ?? '';
    final List<Element> metaElements = element.getElementsByClassName("post-meta-item");
    final Element titleElement = element.getFirstByClass("post-item-title");

    final String postDate = metaElements[0].lastChildText;
    final String diggCount = metaElements[1].lastChildText;
    final String commentCount = metaElements[2].lastChildText;
    final String viewCount = metaElements[3].lastChildText;

    final String url = titleElement.attributes['href']!;

    return BlogResp(
      id: element.attributes['data-post-id']!.toInt(),
      title: titleElement.content,
      url: url,
      description: element.getFirstByClass("post-item-summary").lastNodeText,
      author: element.getFirstByClass("post-item-author").firstChildText,
      avatar: avatar,
      postDate: DateTime.parse(postDate),
      viewCount: viewCount.toInt(),
      commentCount: commentCount.toInt(),
      diggCount: diggCount.toInt(),
    );
  }

  static CategoryInfo _parseCategory(Element element) {
    final String url = element.attributes['href']!;
    final String label = element.content;
    return CategoryInfo(url: url, label: label);
  }
}
