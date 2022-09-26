import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/model/official_blog.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class OfficialBlogParser {
  static List<OfficialBlog> parseOfficialBlogList(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByClassName("day");

    return elements.expand((element) => parseOfficialBlogs(element)).toList();
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

    final String viewCount = descElement.getFirstByClass("post-view-count").getRegexText(r"阅读\(([0-9]+)\)");
    final String commentCount = descElement.getFirstByClass("post-comment-count").getRegexText(r"评论\(([0-9]+)\)");
    final String diggCount = descElement.getFirstByClass("post-digg-count").getRegexText(r"推荐\(([0-9]+)\)");

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
    return Iterable.generate(elements.length ~/ 2)
        .map((index) => _parseHotBlog(elements[index * 2], elements[index * 2 + 1]))
        .toList();
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
