import 'package:flutter_cnblog/common/parser/category_parser.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class UserBlogParser {
  static List<UserBlog> parseUserBlogList(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByClassName("day");
    List<UserBlog> userBlogs = List.empty(growable: true);

    for (final Element element in elements) {
      final List<UserBlog> list = __parseUserBlogs(element);
      userBlogs.addAll(list);
    }
    return userBlogs;
  }

  static List<UserBlog> __parseUserBlogs(Element element) {
    final Element dayTitleElement = element.getElementsByClassName("dayTitle")[0];
    final String dayTitle = dayTitleElement.children.last.firstChild.toString().trimQuotation().trim();

    final List<Element> titleElements = element.getElementsByClassName("postTitle2");
    final List<Element> summaryElements = element.getElementsByClassName("c_b_p_desc");
    final List<Element> postInfoElements = element.getElementsByClassName("postDesc");

    List<UserBlog> userBlogs = List.empty(growable: true);
    for (int i = 0; i < titleElements.length; i++) {
      final UserBlog userBlog = _parseUserBlog2(dayTitle, titleElements[i], summaryElements[i], postInfoElements[i]);
      userBlogs.add(userBlog);
    }
    return userBlogs;
  }

  static UserBlog _parseUserBlog2(String dayTitle, Element titleElement, Element summaryElement, Element postInfoElement) {
    final bool isPinned = titleElement.attributes['class']!.contains("pinned-post");

    final String postInfoString = postInfoElement.firstChild.toString().trimQuotation().trim().replaceFirst("posted @ ", "");
    final String postDateString = postInfoString.split("\n")[0];
    final String name = postInfoString.split("\n")[1];

    final Element viewElement = postInfoElement.getElementsByClassName("post-view-count")[0];
    final RegExp viewRegex = RegExp(r"阅读\(([0-9]+)\)");
    final String viewString = viewRegex.firstMatch(viewElement.outerHtml)!.group(1)!;

    final Element commentElement = postInfoElement.getElementsByClassName("post-comment-count")[0];
    final RegExp commentRegex = RegExp(r"评论\(([0-9]+)\)");
    final String commentString = commentRegex.firstMatch(commentElement.outerHtml)!.group(1)!;

    final Element diggElement = postInfoElement.getElementsByClassName("post-digg-count")[0];
    final RegExp diggRegex = RegExp(r"推荐\(([0-9]+)\)");
    final String diggString = diggRegex.firstMatch(diggElement.outerHtml)!.group(1)!;

    return UserBlog(
      id: int.parse(summaryElement.attributes["id"]!.replaceFirst("postlist_description_", "")),
      title: titleElement.getElementsByTagName("span")[0].outerHtml,
      url: titleElement.attributes['href']!,
      summary: summaryElement.nodes.first.toString().trimQuotation().trim().replaceFirst("摘要：", "").trim(),
      commentCount: int.parse(commentString),
      diggCount: int.parse(diggString),
      viewCount: int.parse(viewString),
      postDate: DateTime.parse(postDateString),
      dayTitle: dayTitle,
      isPinned: isPinned,
      name: name,
    );
  }
}
