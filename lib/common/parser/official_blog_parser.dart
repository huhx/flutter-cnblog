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

  static List<OfficialBlog> parseOfficialBlogs(Element element) {
    final List<Element> titleElements = element.getElementsByClassName("postTitle2");
    final List<Element> summaryElements = element.getElementsByClassName("c_b_p_desc");
    final List<Element> postInfoElements = element.getElementsByClassName("postDesc");

    List<OfficialBlog> userBlogs = List.empty(growable: true);
    for (int i = 0; i < titleElements.length; i++) {
      final OfficialBlog userBlog = parseOfficialBlog(titleElements[i], summaryElements[i], postInfoElements[i]);
      userBlogs.add(userBlog);
    }
    return userBlogs;
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
}
