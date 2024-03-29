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
    final List<Element> elements =
        ulElement.getElementsByTagName("li").where((element) => element.attributes.isEmpty).toList();
    final String displayName = element.getFirstByClass("display_name").content.trim();
    final String name = element.getFirstByClass("link_account").attributes['href']!.split("/")[2];
    final Map<String, String> map = {};
    final String userId = RegExp(r'var currentUserId = "(.+)"').firstMatch(string)!.group(1)!;

    for (final Element ele in elements) {
      final Element keyElement = ele.getFirstByClass("text_gray");
      final String key = keyElement.content.replaceFirst("：", "");
      final Element? nextElement = keyElement.nextElementSibling;
      final String value = nextElement == null ? ele.lastNodeText : nextElement.innerHtml;
      map[key] = value;
    }

    return UserProfileInfo(
      userId: userId,
      name: name,
      displayName: displayName,
      avatar: "https:${element.getFirstByClass("img_avatar").attributes['src']}",
      url: "https://www.cnblogs.com/$name/",
      info: map,
      followCounts: document.getElementById("following_count")!.intContent,
      followerCounts: document.getElementById("follower_count")!.intContent,
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
      name: titleElement.getFirstByClass("feed_author").content,
      avatar: "https:$avatarString",
      url: urlString.startsWith("http") ? urlString : "https:$urlString",
      action: titleElement.nodes[2].toString().trimQuotation().trim().replaceFirst("：", ""),
      title: linkElement.content,
      summary: descElement.content.trim(),
      postDate: titleElement.getFirstByClass("feed_date").content,
    );
  }
}
