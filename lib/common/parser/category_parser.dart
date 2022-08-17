import 'package:flutter_cnblog/common/extension/element_extension.dart';
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
      final List<CategoryInfo> children = _parseCategories(elements.sublist(1));
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
    final List<Element> avatarElement = element.getElementsByClassName("avatar");
    final List<Element> metaElements = element.getElementsByClassName("post-meta-item");
    final Element titleElement = element.getFirstByClass("post-item-title");

    final String postDate = metaElements[0].getLastChildText();
    final String diggCount = metaElements[1].getLastChildText();
    final String commentCount = metaElements[2].getLastChildText();
    final String viewCount = metaElements[3].getLastChildText();

    return BlogResp(
      id: int.parse(element.attributes['data-post-id']!),
      title: titleElement.getText(),
      url: titleElement.attributes['href']!,
      description: element.getFirstByClass("post-item-summary").getLastNodeText(),
      author: element.getFirstByClass("post-item-author").getFirstChildText(),
      blogApp: element.getFirstByClass("post-item-author").getFirstChildText(),
      avatar: avatarElement.isEmpty ? '' : avatarElement[0].attributes['src'] ?? '',
      postDate: DateTime.parse(postDate),
      viewCount: int.parse(viewCount),
      commentCount: int.parse(commentCount),
      diggCount: int.parse(diggCount),
    );
  }

  static CategoryInfo _parseCategory(Element element) {
    final String url = element.attributes['href']!;
    final String label = element.getText();
    return CategoryInfo(url: url, label: label);
  }

  static List<CategoryInfo> _parseCategories(List<Element> element) {
    return element.map((e) => _parseCategory(e)).toList();
  }
}
