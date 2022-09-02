import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class BlogPostInfoParser {
  static BlogPostInfo parseBlogPostInfo(String string) {
    final Document document = parse(string);
    final Element profileElement = document.getElementById("author_profile_info")!;
    final Element diggElement = document.getElementById("div_digg")!;

    final String diggWord = diggElement.getFirstByClass("diggword").getFirstNodeText();
    final bool isDigg = diggWord.contains("已推荐");
    final bool isBury = diggWord.contains("已反对");

    return BlogPostInfo(
      followingCount: profileElement.getFirstByClass("following-count").getText().toInt(),
      followerCount: profileElement.getFirstByClass("follower-count").getText().toInt(),
      diggCount: diggElement.getFirstByClass("diggnum").getText().toInt(),
      buryCount: diggElement.getFirstByClass("burynum").getText().toInt(),
      isDigg: isDigg,
      isBury: isBury,
    );
  }
}