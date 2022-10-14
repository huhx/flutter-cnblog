import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/my_search_parser.dart';
import 'package:flutter_cnblog/common/parser/search_parser.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_cnblog/util/dio_util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchApi {

  Future<List<SearchInfo>> getSearchContents(SearchType searchType, int pageKey, String keyword) async {
    final Response response = await RestClient.withCookie().get(
      "https://zzk.cnblogs.com/s/${searchType.path}",
      queryParameters: {"Keywords": keyword, "pageindex": pageKey},
      options: Options(headers: {"cookie": "NotRobot=${dotenv.env['notRobotCookie']}"}),
    );

    return compute(SearchParser.parseSearchList, response.data as String);
  }

  Future<List<SearchInfo>> getMySearchContents(MySearchType searchType, int pageKey, String keyword) async {
    final Response response = await RestClient.withCookie().get(
      "https://zzk.cnblogs.com/my/s/${searchType.path}",
      queryParameters: {"Keywords": keyword, "pageindex": pageKey},
      options: Options(headers: {"cookie": "NotRobot=${dotenv.env['notRobotCookie']}"}),
    );

    return compute(MySearchParser.parseSearchList, response.data as String);
  }
}

final searchApi = SearchApi();
