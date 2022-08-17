import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/constant/token_type.dart';
import 'package:flutter_cnblog/common/parser/news_parser.dart';
import 'package:flutter_cnblog/model/news.dart';
import 'package:flutter_cnblog/util/dio_util.dart';

class NewsApi {
  static const String url = "https://news.cnblogs.com/n";

  Future<List<NewsInfo>> getAllNewses(NewsCategory category, int pageKey) async {
    final Dio dio = RestClient.getInstance(tokenType: TokenType.none);

    switch (category) {
      case NewsCategory.lasted:
        final Response response = await dio.get("$url/page/$pageKey/");
        return compute(NewsParser.parseNewsList, response.data as String);
      case NewsCategory.recommend:
        final Response response = await dio.get("$url/recommend?page=$pageKey");
        return compute(NewsParser.parseNewsList, response.data as String);
      case NewsCategory.hot:
        final Response response = await dio.get("$url/digg?type=month&page=$pageKey");
        return compute(NewsParser.parseNewsList, response.data as String);
    }
  }
}

final newsApi = NewsApi();
