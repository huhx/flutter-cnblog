import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class BlogDataParser {
  static BlogDataInfo parseBlogDataList(String string) {
    final Document document = parse(string);
    final String blogString = document.getElementById("stats_post_count")!.getText();
    final String articleString = document.getElementById("stats_article_count")!.getText();
    final String commentString = document.getElementById("stats-comment_count")!.getText();
    final Element viewElement = document.getElementById("stats-total-view-count")!;
    final String viewString = viewElement.getFirstByTag("span").attributes['title']!.split(":")[1].trim();

    return BlogDataInfo(
      blogCount: blogString.split("-")[1].trim().toInt(),
      articleCount: articleString.split("-")[1].trim().toInt(),
      commentCount: commentString.split("-")[1].trim().toInt(),
      viewCount: viewString.toInt(),
    );
  }
}
