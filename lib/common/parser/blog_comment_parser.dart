import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class BlogCommentParser {
  static List<BlogComment> parseBlogCommentList(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByClassName("feedbackItem");

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

    final Element diggElement = voteElement.getFirstByClass("comment_digg");
    final RegExp diggRegex = RegExp(r"支持\(([0-9]+)\)");
    final String diggString = diggRegex.firstMatch(diggElement.getText())!.group(1)!;

    final Element buryElement = voteElement.getFirstByClass("comment_burry");
    final RegExp buryRegex = RegExp(r"反对\(([0-9]+)\)");
    final String buryString = buryRegex.firstMatch(buryElement.getText())!.group(1)!;

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
