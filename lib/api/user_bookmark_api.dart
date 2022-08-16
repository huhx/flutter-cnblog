import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/bookmark_parser.dart';
import 'package:flutter_cnblog/model/bookmark.dart';
import 'package:flutter_cnblog/util/app_config.dart';

class UserBookmarkApi {
  Future<List<BookmarkInfo>> getUserBookmarkList(int pageKey) async {
    final String url = "https://wz.cnblogs.com/my/$pageKey.html";
    final Response response = await Dio(BaseOptions(
      headers: {
        "Cookie": ".Cnblogs.AspNetCore.Cookies=${AppConfig.get("cookie")}",
        "x-requested-with": "XMLHttpRequest",
      },
    )).get(url);
    return compute(BookmarkParser.parseBookmarkList, response.data as String);
  }
}

final userBookmarkApi = UserBookmarkApi();
