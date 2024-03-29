import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:app_common_flutter/extension.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class UserBlogParser {
  static List<UserBlog> parseUserBlogList(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByClassName("day");

    return elements.expand((element) => __parseUserBlogs(element)).toList();
  }

  static List<UserBlog> __parseUserBlogs(Element element) {
    final Element dayTitleElement = element.getFirstByClass("dayTitle");
    final List<String> dayInfo =
        dayTitleElement.children.first.attributes['href']!.split('archive/')[1].split('.')[0].split("/");

    final String dayTitle = "${dayInfo[0]}年${dayInfo[1]}月${dayInfo[2]}日";

    final List<Element> titleElements = element.getElementsByClassName("postTitle2");
    final List<Element> summaryElements = element.getElementsByClassName("c_b_p_desc");
    final List<Element> postInfoElements = element.getElementsByClassName("postDesc");

    return Iterable.generate(titleElements.length)
        .map((i) => _parseUserBlog(dayTitle, titleElements[i], summaryElements[i], postInfoElements[i]))
        .toList();
  }

  static UserBlog _parseUserBlog(
      String dayTitle, Element titleElement, Element summaryElement, Element postInfoElement) {
    final bool isPinned = titleElement.attributes['class']!.contains("pinned-post");

    final String postInfoString = postInfoElement.content.replaceFirst("posted @ ", "").trim();
    final String postDateString = postInfoString.split("\n")[0];
    final String name = postInfoString.split("\n")[1];

    final Element viewElement = postInfoElement.getFirstByClass("post-view-count");
    final String viewString = viewElement.getRegexText(r"阅读\(([0-9]+)\)");

    final Element commentElement = postInfoElement.getFirstByClass("post-comment-count");
    final String commentString = commentElement.getRegexText(r"评论\(([0-9]+)\)");

    final Element diggElement = postInfoElement.getFirstByClass("post-digg-count");
    final String diggString = diggElement.getRegexText(r"推荐\(([0-9]+)\)");

    return UserBlog(
      id: summaryElement.attributes["id"]!.replaceFirst("postlist_description_", "").toInt(),
      title: titleElement.getFirstByTag("span").lastNodeText,
      url: titleElement.attributes['href']!,
      summary: summaryElement.firstNodeText.replaceFirst("摘要：", "").trim(),
      commentCount: commentString.toInt(),
      diggCount: diggString.toInt(),
      viewCount: viewString.toInt(),
      postDate: DateTime.parse(postDateString),
      dayTitle: dayTitle,
      isPinned: isPinned,
      name: name,
    );
  }
}
