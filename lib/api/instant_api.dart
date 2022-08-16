import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/instant_parser.dart';
import 'package:flutter_cnblog/model/instant.dart';
import 'package:flutter_cnblog/util/dio_util.dart';

class InstantApi {
  Future<List<InstantInfo>> getAllInstants(InstantCategory category, int pageKey) async {
    final String url =
        "https://ing.cnblogs.com/ajax/ing/GetIngList?IngListType=${category.url}&PageIndex=$pageKey&_=${DateTime.now().microsecondsSinceEpoch}";
    final Response response = await RestClient.withCookie().get(url);
    return compute(InstantParser.parseInstantList, response.data as String);
  }

  Future<List<InstantInfo>> getMyInstants(MyInstantCategory category, int pageKey) async {
    final String url =
        "https://ing.cnblogs.com/ajax/ing/GetIngList?IngListType=${category.url}&PageIndex=$pageKey&_=${DateTime.now().microsecondsSinceEpoch}";
    final Response response = await RestClient.withCookie().get(url);
    return compute(InstantParser.parseInstantList, response.data as String);
  }
}

final instantApi = InstantApi();
