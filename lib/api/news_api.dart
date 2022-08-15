import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/news_parser.dart';
import 'package:flutter_cnblog/model/news.dart';

class NewsApi {
  Future<List<NewsInfo>> getAllNewses(NewsCategory category, int pageKey) async {
    switch (category) {
      case NewsCategory.lasted:
        final Response response = await Dio().get("https://news.cnblogs.com/n/page/$pageKey/");
        return compute(NewsParser.parseNewsList, response.data as String);
      case NewsCategory.recommend:
        final Response response = await Dio().get("https://news.cnblogs.com/n/recommend?page=$pageKey");
        return compute(NewsParser.parseNewsList, response.data as String);
      case NewsCategory.hot:
        final Response response = await Dio().get("https://news.cnblogs.com/n/digg?type=month&page=$pageKey");
        return compute(NewsParser.parseNewsList, response.data as String);
    }
  }
}

final newsApi = NewsApi();
