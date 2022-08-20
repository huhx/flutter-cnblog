import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/constant/token_type.dart';
import 'package:flutter_cnblog/common/parser/search_parser.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_cnblog/util/dio_util.dart';

class SearchApi {
  final String url = "https://zzk.cnblogs.com/s";
  final String myUrl = "https://zzk.cnblogs.com/my/s";

  Future<List<SearchInfo>> getSearchContents(SearchType searchType, int pageKey, String keyword) async {
    final Dio dio = RestClient.getInstance(tokenType: TokenType.none);
    final Response response = await dio.get(
      "$url/${searchType.url}?Keywords=$keyword&pageindex=$pageKey",
      options: Options(headers: {
        "cookie": "NotRobot=CfDJ8EOBBtWq0dNFoDS-ZHPSe51ATHuFFilG3imii1Hj5WZ-TAK98xT4mJquvSMlYdkzfVCmpAWdt1VyGSpqZ5Q8GulXT3q-Essgs3ttLCLRTzIqo0Klt-nZCkblG6ST2zI2Og;"
      }),
    );

    return compute(SearchParser.parseSearchList, response.data as String);
  }
}

final searchApi = SearchApi();
