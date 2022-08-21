import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
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
      final String key = ele.getFirstByClass("text_gray").getText().replaceFirst("：", "");
      final String value = ele.nodes.last.nodes.isNotEmpty
          ? ele.nodes.last.nodes.last.toString().trimQuotation().trim()
          : ele.nodes.last.toString().trimQuotation().trim();
      map[key] = value;
    }

    return UserProfileInfo(
      name: element.getFirstByClass("display_name").getText().trim(),
      avatar: "https:${element.getFirstByClass("img_avatar").attributes['src']}",
      url: document.getElementById("blog_url")!.attributes['href']!,
      info: map,
      followCounts: document.getElementById("following_count")!.getText().toInt(),
      followerCounts: document.getElementById("follower_count")!.getText().toInt(),
    );
  }

  static List<UserProfileMoment> parseUserProfileMoment(String string) {
    final Document document = parse(string);
    final List<Element> elements = document.getElementsByClassName("feed_item");

    return elements.map((e) => _parseUserProfileMoment(e)).toList();
  }

  static UserProfileMoment _parseUserProfileMoment(Element element) {
    final String avatarString = element.getFirstByClass("feed_avatar").getFirstByTag("img").attributes['src']!;
    final Element bodyElement = element.getFirstByClass("feed_body");

    final Element titleElement = bodyElement.getFirstByClass("feed_title");
    final Element descElement = bodyElement.getFirstByClass("feed_desc");
    final Element linkElement = bodyElement.getFirstByClass("feed_link");
    final String urlString = linkElement.attributes['href']!;

    return UserProfileMoment(
      name: titleElement.getFirstByClass("feed_author").getText(),
      avatar: "https:$avatarString",
      url: urlString.startsWith("http") ? urlString : "https:$urlString",
      action: titleElement.nodes[2].toString().trimQuotation().trim().replaceFirst("：", ""),
      title: linkElement.getText(),
      summary: descElement.getText().trim(),
      postDate: titleElement.getFirstByClass("feed_date").getText(),
    );
  }
}
