import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/follow_parser.dart';
import 'package:flutter_cnblog/model/follow.dart';
import 'package:flutter_cnblog/util/dio_util.dart';

class UserFollowApi {
  Future<List<FollowInfo>> getUserFollowList(String name, FollowType type, int pageKey) async {
    final String url = "https://home.cnblogs.com/u/$name/relation/${type.url}?page=$pageKey";
    final Response response = await RestClient.withCookie().get(url);

    return compute(FollowParser.parseFollowList, response.data as String);
  }

  Future<FollowResult> follow(String userId, String remark) async {
    const String url = "https://home.cnblogs.com/ajax/follow/followUser";
    final Response response = await RestClient.withCookie().post(
      url,
      data: {"userId": userId, "remark": remark},
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    return FollowResult.fromJson(response.data);
  }

  Future<bool> isFollow(String userId) async {
    final String url = "https://www.cnblogs.com/huhx/ajax/Follow/GetFollowStatus.aspx?blogUserGuid=$userId";
    final Response response = await RestClient.withCookie().get(url);

    return (response.data as String).contains("unfollow");
  }

  Future<FollowResult> unfollow(String userId) async {
    const String url = "https://home.cnblogs.com/ajax/follow/RemoveFollow";
    final Response response = await RestClient.withCookie().post(
      url,
      data: {"userId": userId, "isRemoveGroup": false},
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    return FollowResult.fromJson(response.data);
  }
}

final userFollowApi = UserFollowApi();
