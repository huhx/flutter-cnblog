import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class BlogDataParser {
  static BlogDataInfo parseBlogDataList(String string) {
    final Document document = parse(string);
    final String viewString = document.getElementsByTagName("span").last.attributes['title']!.split(":")[1].trim();
    final List<int> dataList = RegExp(r"([0-9]+)&nbsp;").allMatches(string).map((e) => e.group(1)!.toInt()).toList();

    return BlogDataInfo(
      blogCount: dataList[0],
      articleCount: dataList[1],
      commentCount: dataList[2],
      viewCount: viewString.toInt(),
    );
  }
}
