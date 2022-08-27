import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
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
    final Element dayTitleElement = element.getFirstByClass("dayTitle");
    final String dayTitle = dayTitleElement.getFirstChildText();

    final List<Element> titleElements = element.getElementsByClassName("postTitle2");
    final List<Element> summaryElements = element.getElementsByClassName("c_b_p_desc");
    final List<Element> postInfoElements = element.getElementsByClassName("postDesc");

    List<UserBlog> userBlogs = List.empty(growable: true);
    for (int i = 0; i < titleElements.length; i++) {
      final UserBlog userBlog = _parseUserBlog(dayTitle, titleElements[i], summaryElements[i], postInfoElements[i]);
      userBlogs.add(userBlog);
    }
    return userBlogs;
  }

  static UserBlog _parseUserBlog(String dayTitle, Element titleElement, Element summaryElement, Element postInfoElement) {
    final bool isPinned = titleElement.attributes['class']!.contains("pinned-post");

    final String postInfoString = postInfoElement.getText().replaceFirst("posted @ ", "").trim();
    final String postDateString = postInfoString.split("\n")[0];
    final String name = postInfoString.split("\n")[1];

    final Element viewElement = postInfoElement.getFirstByClass("post-view-count");
    final RegExp viewRegex = RegExp(r"阅读\(([0-9]+)\)");
    final String viewString = viewRegex.firstMatch(viewElement.innerHtml)!.group(1)!;

    final Element commentElement = postInfoElement.getFirstByClass("post-comment-count");
    final RegExp commentRegex = RegExp(r"评论\(([0-9]+)\)");
    final String commentString = commentRegex.firstMatch(commentElement.innerHtml)!.group(1)!;

    final Element diggElement = postInfoElement.getFirstByClass("post-digg-count");
    final RegExp diggRegex = RegExp(r"推荐\(([0-9]+)\)");
    final String diggString = diggRegex.firstMatch(diggElement.innerHtml)!.group(1)!;

    return UserBlog(
      id: summaryElement.attributes["id"]!.replaceFirst("postlist_description_", "").toInt(),
      title: titleElement.getFirstByTag("span").getLastNodeText(),
      url: titleElement.attributes['href']!,
      summary: summaryElement.getFirstNodeText().replaceFirst("摘要：", "").trim(),
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
