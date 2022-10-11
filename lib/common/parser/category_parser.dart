import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/common/support/comm_parser.dart';
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

    final String postDate = metaElements[0].getLastChildText();
    final String diggCount = metaElements[1].getLastChildText();
    final String commentCount = metaElements[2].getLastChildText();
    final String viewCount = metaElements[3].getLastChildText();

    final String url = titleElement.attributes['href']!;

    return BlogResp(
      id: element.attributes['data-post-id']!.toInt(),
      title: titleElement.getText(),
      url: url,
      description: element.getFirstByClass("post-item-summary").getLastNodeText(),
      author: element.getFirstByClass("post-item-author").getFirstChildText(),
      blogApp: Comm.getNameFromBlogUrl(url),
      avatar: avatar,
      postDate: DateTime.parse(postDate),
      viewCount: viewCount.toInt(),
      commentCount: commentCount.toInt(),
      diggCount: diggCount.toInt(),
    );
  }

  static CategoryInfo _parseCategory(Element element) {
    final String url = element.attributes['href']!;
    final String label = element.getText();
    return CategoryInfo(url: url, label: label);
  }
}
