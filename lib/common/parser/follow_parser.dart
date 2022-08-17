import 'package:flutter_cnblog/common/extension/element_extension.dart';
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
    final Element displayNameElement = element.getFirstByClass("avatar_name");
    final Element avatarElement = element.getFirstByClass("avatar_pic");
    final Element linkElement = element.getFirstByTag("a");
    final String linkString = linkElement.attributes["href"]!;
    final String titleString = linkElement.attributes["title"]!;

    return FollowInfo(
      name: linkString.replaceFirst("/u/", ""),
      displayName: displayNameElement.getText(),
      url: "https://home.cnblogs.com$linkString",
      avatar: "https:${avatarElement.children[0].attributes["src"]!}",
      followDate: DateTime.parse(titleString.substring(titleString.length - 10)),
    );
  }
}
