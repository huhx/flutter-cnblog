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
}