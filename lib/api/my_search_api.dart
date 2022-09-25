import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/my_search_parser.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_cnblog/util/dio_util.dart';

class MySearchApi {
  final String url = "https://zzk.cnblogs.com/my/s";

  Future<List<SearchInfo>> getMySearchContents(MySearchType searchType, int pageKey, String keyword) async {
    final Dio dio = RestClient.withCookie();
    final Response response = await dio.get("$url/${searchType.path}?Keywords=$keyword&pageindex=$pageKey");

    return compute(MySearchParser.parseSearchList, response.data as String);
  }
}

final mySearchApi = MySearchApi();
