import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/follow_parser.dart';
import 'package:flutter_cnblog/model/follow.dart';
import 'package:flutter_cnblog/util/dio_util.dart';

class UserFollowApi {
  Future<List<FollowInfo>> getUserFollowList(FollowType type, int pageKey) async {
    final String url = "https://home.cnblogs.com/u/huhx/relation/${type.url}?page=$pageKey";
    final Response response = await RestClient.withCookie().get(url);

    return compute(FollowParser.parseFollowList, response.data as String);
  }
}

final userFollowApi = UserFollowApi();
