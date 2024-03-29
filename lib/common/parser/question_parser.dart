import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:app_common_flutter/extension.dart';
import 'package:flutter_cnblog/model/question.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class QuestionParser {
  static List<QuestionInfo> parseQuestionList(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByClassName("one_entity");

    return elements.map((e) => _parseQuestion(e)).toList();
  }

  static QuestionInfo _parseQuestion(Element element) {
    final List<Element> avatarElement = element.getElementsByClassName("author");
    final Element titleElement = element.getFirstByTag("a");
    final Element submitterElement = element.getFirstByClass("news_contributor");

    final String url = titleElement.attributes['href']!;
    final String gold = element.getFirstOrNullByClass("gold")?.content ?? "0";
    final String summary = element.getFirstByClass("news_summary").content.trim();
    final String date = element.getFirstByClass("date").attributes['title']!;

    final Element footerElement = element.getFirstByClass("news_footer_user");
    final String answerString = footerElement.getRegexText(r"回答\(([0-9]+)\)");
    final String viewString = footerElement.getRegexText(r"浏览\(([0-9]+)\)");

    return QuestionInfo(
      id: url.split("/")[2].toInt(),
      title: titleElement.content,
      url: url,
      summary: summary,
      avatar: avatarElement.isEmpty ? '' : "https:${avatarElement[0].children[0].attributes['src']}",
      homeUrl: submitterElement.attributes['href']!,
      submitter: submitterElement.content.trim(),
      answerCount: answerString.toInt(),
      goldCount: gold.toInt(),
      viewCount: viewString.toInt(),
      postDate: date.startsWith("解决于 ") ? null : DateTime.parse(date),
      answeredDate: date.startsWith("解决于 ") ? DateTime.parse(date.replaceAll("解决于 ", "").trim()) : null,
    );
  }
}
