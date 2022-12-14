import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class BlogPostInfoParser {
  static BlogPostInfo parseBlogPostInfo(String string) {
    final Document document = parse(string);
    final Element profileElement = document.getElementById("author_profile_info")!;
    final Element diggElement = document.getElementById("div_digg")!;

    final String diggWord = diggElement.getFirstByClass("diggword").firstNodeText;
    final bool isDigg = diggWord.contains("已推荐");
    final bool isBury = diggWord.contains("已反对");

    return BlogPostInfo(
      followingCount: profileElement.getFirstByClass("following-count").intContent,
      followerCount: profileElement.getFirstByClass("follower-count").intContent,
      diggCount: diggElement.getFirstByClass("diggnum").intContent,
      buryCount: diggElement.getFirstByClass("burynum").intContent,
      isDigg: isDigg,
      isBury: isBury,
    );
  }
}
