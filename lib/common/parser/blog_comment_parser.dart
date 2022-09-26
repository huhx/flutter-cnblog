import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class BlogCommentParser {
  static List<BlogComment> parseBlogCommentList(String string) {
    if (string.isEmpty) {
      return [];
    }
    final Document document = parse(string);
    final Element previousElement = document.getElementsByClassName("feedbackNoItems")[0];
    final String elementName = previousElement.nextElementSibling?.attributes["class"]! ?? "post";
    final List<Element> elements = document.getElementsByClassName(elementName);
    return elements.map((e) => _parseBlogComment(e)).toList();
  }

  static BlogComment _parseBlogComment(Element element) {
    final Element idElement = element.getFirstByClass("layer");
    final Element tokenElement = element.getFirstByClass("comment_actions").getFirstByTag("a");
    final bool isMe = tokenElement.attributes["onclick"]!.contains("CommentBody");

    String? tokenString;
    if (!isMe) {
      tokenString = tokenElement.attributes["onclick"]!.split(", ")[1];
      tokenString = tokenString.substring(1, tokenString.length - 2);
    }

    final Element contentElement = element.getFirstByClass("blog_comment_body");
    final Element dateElement = element.getFirstByClass("comment_date");
    final Element authorElement = dateElement.nextElementSibling!;

    final Element voteElement = element.getFirstByClass("comment_vote");
    final String diggString = voteElement.getFirstByClass("comment_digg").getRegexText(r"支持\(([0-9]+)\)");
    final String buryString = voteElement.getFirstByClass("comment_burry").getRegexText(r"反对\(([0-9]+)\)");

    return BlogComment(
      id: idElement.attributes['href']!.replaceFirst("#", "").toInt(),
      content: contentElement.innerHtml.trim(),
      isMe: isMe,
      replyToken: tokenString,
      author: authorElement.getText(),
      homeUrl: authorElement.attributes["href"]!,
      diggCount: diggString.toInt(),
      buryCount: buryString.toInt(),
      postDate: dateElement.getText(),
    );
  }
}
