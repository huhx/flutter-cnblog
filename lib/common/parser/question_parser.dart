import 'package:flutter_cnblog/common/parser/category_parser.dart';
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
    final Element titleElement = element.getElementsByTagName("a")[0];
    final Element submitterElement = element.getElementsByClassName("news_contributor")[0];
    final List<Element> goldElements = element.getElementsByClassName("gold");


    final String url = titleElement.attributes['href']!;
    final String gold = goldElements.isNotEmpty ? goldElements[0].firstChild.toString().trimQuotation() : "0";
    final String summary = element.getElementsByClassName("news_summary")[0].firstChild.toString().trimQuotation().trim();
    final String date = element.getElementsByClassName("date")[0].attributes['title']!;

    final Element footerElement = element.getElementsByClassName("news_footer_user")[0];
    final RegExp answerRegex = RegExp(r"回答\(([0-9]+)\)");
    final String answerString = answerRegex.firstMatch(footerElement.outerHtml)!.group(1)!;

    final RegExp viewRegex = RegExp(r"浏览\(([0-9]+)\)");
    final String viewString = viewRegex.firstMatch(footerElement.outerHtml)!.group(1)!;

    return QuestionInfo(
      id: int.parse(url.split("/")[2]),
      title: titleElement.firstChild.toString().trimQuotation(),
      url: url,
      summary: summary,
      avatar: avatarElement.isEmpty ? '' : "https:${avatarElement[0].children[0].attributes['src']}",
      homeUrl: submitterElement.attributes['href']!,
      submitter: submitterElement.firstChild.toString().trimQuotation().trim(),
      answerCount: int.parse(answerString),
      goldCount: int.parse(gold),
      viewCount: int.parse(viewString),
      pastDate: date.startsWith("解决于 ") ? null : DateTime.parse(date),
      answeredDate: date.startsWith("解决于 ") ? DateTime.parse(date.replaceAll("解决于 ", "").trim()) : null,
    );
  }
}