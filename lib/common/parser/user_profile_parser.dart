import 'package:flutter_cnblog/common/parser/category_parser.dart';
import 'package:flutter_cnblog/model/user_profile.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class UserProfileParser {
  static UserProfileInfo parseUserProfile(String string) {
    final Document document = parse(string);
    final Element element = document.getElementById("user_profile_block")!;
    final Element ulElement = element.getElementsByTagName("ul")[1];
    final List<Element> elements = ulElement.getElementsByTagName("li").where((element) => element.attributes.isEmpty).toList();
    final Map<String, String> map = {};

    for (final Element ele in elements) {
      final String key = ele.getElementsByClassName("text_gray")[0].firstChild.toString().trimQuotation().trim().replaceFirst("：", "");
      final String value = ele.nodes.last.nodes.isNotEmpty
          ? ele.nodes.last.nodes.last.toString().trimQuotation().trim()
          : ele.nodes.last.toString().trimQuotation().trim();
      map[key] = value;
    }

    return UserProfileInfo(
      name: element.getElementsByClassName("display_name")[0].firstChild.toString().trimQuotation().trim(),
      avatar: "https:${element.getElementsByClassName("img_avatar")[0].attributes['src']}",
      url: document.getElementById("blog_url")!.attributes['href']!,
      info: map,
      followCounts: int.parse(document.getElementById("following_count")!.firstChild.toString().trimQuotation()),
      followerCounts: int.parse(document.getElementById("follower_count")!.firstChild.toString().trimQuotation()),
    );
  }

  static List<UserProfileMoment> parseUserProfileMoment(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByClassName("feed_item");

    return elements.map((e) => _parseUserProfileMoment(e)).toList();
  }

  static UserProfileMoment _parseUserProfileMoment(Element element) {
    final String avatarString = element.getElementsByClassName("feed_avatar")[0].getElementsByTagName("img")[0].attributes['src']!;
    final Element bodyElement = element.getElementsByClassName("feed_body")[0];

    final Element titleElement = bodyElement.getElementsByClassName("feed_title")[0];
    final Element descElement = bodyElement.getElementsByClassName("feed_desc")[0];
    final Element linkElement = bodyElement.getElementsByClassName("feed_link")[0];

    return UserProfileMoment(
      name: titleElement.getElementsByClassName("feed_author")[0].firstChild.toString().trimQuotation().trim(),
      avatar: "https:$avatarString",
      url: linkElement.attributes['href']!,
      action: titleElement.nodes[2].toString().trimQuotation().trim().replaceFirst("：", ""),
      title: linkElement.nodes.last.toString().trimQuotation().trim(),
      summary: descElement.nodes.last.toString().trimQuotation().trim(),
      postDate: titleElement.getElementsByClassName("feed_date")[0].firstChild.toString().trimQuotation().trim(),
    );
  }
}