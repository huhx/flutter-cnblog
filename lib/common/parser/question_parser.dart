import 'package:flutter_cnblog/common/extension/element_extension.dart';
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
    final List<Element> goldElements = element.getElementsByClassName("gold");

    final String url = titleElement.attributes['href']!;
    final String gold = goldElements.isNotEmpty ? goldElements[0].getText() : "0";
    final String summary = element.getFirstByClass("news_summary").getText().trim();
    final String date = element.getFirstByClass("date").attributes['title']!;

    final Element footerElement = element.getFirstByClass("news_footer_user");
    final RegExp answerRegex = RegExp(r"回答\(([0-9]+)\)");
    final String answerString = answerRegex.firstMatch(footerElement.outerHtml)!.group(1)!;

    final RegExp viewRegex = RegExp(r"浏览\(([0-9]+)\)");
    final String viewString = viewRegex.firstMatch(footerElement.outerHtml)!.group(1)!;

    return QuestionInfo(
      id: int.parse(url.split("/")[2]),
      title: titleElement.getText(),
      url: url,
      summary: summary,
      avatar: avatarElement.isEmpty ? '' : "https:${avatarElement[0].children[0].attributes['src']}",
      homeUrl: submitterElement.attributes['href']!,
      submitter: submitterElement.getText(),
      answerCount: int.parse(answerString),
      goldCount: int.parse(gold),
      viewCount: int.parse(viewString),
      pastDate: date.startsWith("解决于 ") ? null : DateTime.parse(date),
      answeredDate: date.startsWith("解决于 ") ? DateTime.parse(date.replaceAll("解决于 ", "").trim()) : null,
    );
  }
}
