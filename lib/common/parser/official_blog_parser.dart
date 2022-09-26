import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/model/official_blog.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class OfficialBlogParser {
  static List<OfficialBlog> parseOfficialBlogList(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByClassName("day");
    List<OfficialBlog> userBlogs = List.empty(growable: true);

    for (final Element element in elements) {
      userBlogs.addAll(parseOfficialBlogs(element));
    }
    return userBlogs;
  }

  static List<OfficialHot> parseOfficialHotList(String string) {
    final Document document = parse(string);
    final Element rootElement = document.getElementById("cnblogs_post_body")!;

    final List<Element> elements = rootElement.getElementsByTagName("p");
    List<OfficialHot> hotBlogList = _parseHotBlogList(elements[1]);
    List<OfficialHot> hotNewsList = _parseHotNewsList(elements[3]);

    return hotBlogList + hotNewsList;
  }

  static List<OfficialBlog> parseOfficialBlogs(Element element) {
    final List<Element> titleElements = element.getElementsByClassName("postTitle2");
    final List<Element> summaryElements = element.getElementsByClassName("c_b_p_desc");
    final List<Element> postInfoElements = element.getElementsByClassName("postDesc");

    return Iterable.generate(titleElements.length)
        .map((i) => parseOfficialBlog(titleElements[i], summaryElements[i], postInfoElements[i]))
        .toList();
  }

  static OfficialBlog parseOfficialBlog(Element titleElement, Element summaryElement, Element descElement) {
    final String id = titleElement.attributes["href"]!.split("/").last.replaceFirst(".html", "");
    final String title = titleElement.getFirstByTag("span").getText().trim();

    final RegExp viewRegex = RegExp(r"阅读\(([0-9]+)\)");
    final String viewString = descElement.getFirstByClass("post-view-count").getText();
    final String viewCount = viewRegex.firstMatch(viewString)!.group(1)!;

    final RegExp commentRegex = RegExp(r"评论\(([0-9]+)\)");
    final String commentString = descElement.getFirstByClass("post-comment-count").getText();
    final String commentCount = commentRegex.firstMatch(commentString)!.group(1)!;

    final RegExp diggRegex = RegExp(r"推荐\(([0-9]+)\)");
    final String diggString = descElement.getFirstByClass("post-digg-count").getText();
    final String diggCount = diggRegex.firstMatch(diggString)!.group(1)!;

    return OfficialBlog(
      id: id,
      title: title,
      url: titleElement.attributes["href"]!,
      summary: summaryElement.getFirstNodeText().split("\n")[1].trim(),
      isReview: title.contains("上周热点回顾"),
      postDate: descElement.getText().split(" @ ")[1].split("\n")[0].trim(),
      viewCount: viewCount.toInt(),
      commentCount: commentCount.toInt(),
      diggCount: diggCount.toInt(),
    );
  }

  static List<OfficialHot> _parseHotBlogList(Element element) {
    final List<Element> elements = element.getElementsByTagName("a");
    final int length = elements.length;
    List<Element> oddElements = [];
    List<Element> evenElements = [];
    for (int i = 0; i < length; i++) {
      if ((i + 1) % 2 == 0) {
        evenElements.add(elements[i]);
      } else {
        oddElements.add(elements[i]);
      }
    }
    final int size = evenElements.length;
    List<OfficialHot> result = [];
    for (int j = 0; j < size; j++) {
      result.add(_parseHotBlog(oddElements[j], evenElements[j]));
    }
    return result;
  }

  static OfficialHot _parseHotBlog(Element blogElement, Element userElement) {
    final String url = blogElement.attributes["href"]!;
    return OfficialHot(
      id: url.split("/").last.replaceFirst(".html", ""),
      title: blogElement.getText(),
      url: url,
      name: userElement.getText(),
      homeUrl: userElement.attributes["href"],
      isBlog: true,
    );
  }

  static List<OfficialHot> _parseHotNewsList(Element element) {
    final List<Element> elements = element.getElementsByTagName("a");
    return elements.map((e) => _parseHotNews(e)).toList();
  }

  static OfficialHot _parseHotNews(Element element) {
    final String url = element.attributes["href"]!;
    final List<String> urlPart = url.split("/");
    return OfficialHot(
      id: urlPart[urlPart.length - 2],
      title: element.getText(),
      url: url,
      name: "itwriter",
      isBlog: false,
    );
  }
}
