import 'package:flutter_cnblog/common/parser/category_parser.dart';
import 'package:flutter_cnblog/model/follow.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class FollowParser {
  static List<FollowInfo> parseFollowList(String string) {
    final Document document = parse(string);
    final Element rootElement = document.getElementsByClassName("avatar_list")[0];
    final List<Element> elements = rootElement.getElementsByTagName("li");

    return elements.map((e) => _parseFollow(e)).toList();
  }

  static FollowInfo _parseFollow(Element element) {
    final Element displayNameElement = element.getElementsByClassName("avatar_name")[0];
    final Element avatarElement = element.getElementsByClassName("avatar_pic")[0];
    final Element linkElement = element.getElementsByTagName("a")[0];
    final String linkString = linkElement.attributes["href"]!;
    final String titleString = linkElement.attributes["title"]!;

    return FollowInfo(
      name: linkString.replaceFirst("/u/", ""),
      displayName: displayNameElement.firstChild.toString().trimQuotation().trim(),
      url: "https://home.cnblogs.com$linkString",
      avatar: "https:${avatarElement.children[0].attributes["src"]!}",
      followDate: DateTime.parse(titleString.substring(titleString.length - 10)),
    );
  }
}
