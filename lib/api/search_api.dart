import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/my_search_parser.dart';
import 'package:flutter_cnblog/common/parser/search_parser.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_cnblog/util/dio_util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchApi {
  final String url = "https://zzk.cnblogs.com/s";
  final String myUrl = "https://zzk.cnblogs.com/my/s";

  Future<List<SearchInfo>> getSearchContents(SearchType searchType, int pageKey, String keyword) async {
    final Dio dio = RestClient.withCookie();
    final Response response = await dio.get(
      "$url/${searchType.path}?Keywords=$keyword&pageindex=$pageKey",
      options: Options(headers: {"cookie": "NotRobot=${dotenv.env['notRobotCookie']}"}),
    );

    return compute(SearchParser.parseSearchList, response.data as String);
  }

  Future<List<SearchInfo>> getMySearchContents(MySearchType searchType, int pageKey, String keyword) async {
    final Dio dio = RestClient.withCookie();
    final Response response = await dio.get(
      "$myUrl/${searchType.path}?Keywords=$keyword&pageindex=$pageKey",
      options: Options(headers: {"cookie": "NotRobot=${dotenv.env['notRobotCookie']}"}),
    );

    return compute(MySearchParser.parseSearchList, response.data as String);
  }
}

final searchApi = SearchApi();
