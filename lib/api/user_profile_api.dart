import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/api/user_blog_data_api.dart';
import 'package:flutter_cnblog/common/parser/user_profile_parser.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:flutter_cnblog/model/user_profile.dart';
import 'package:flutter_cnblog/util/dio_util.dart';

class UserProfileApi {
  Future<UserProfileInfo> getUserProfile(String name) async {
    final String url = "https://home.cnblogs.com/u/$name/";
    final Response response = await RestClient.withCookie().get(url);

    return compute(UserProfileParser.parseUserProfile, response.data as String);
  }

  Future<List<UserProfileMoment>> getUserProfileMoment(String name, int pageKey) async {
    final String url = "https://home.cnblogs.com/ajax/feed/recent?alias=$name";
    final requestBody = {
      "feedListType": "me",
      "appId": "",
      "pageIndex": 1,
      "pageSize": 30,
      "groupId": "",
    };
    final Response response = await RestClient.withCookie().post(url, data: requestBody);

    return compute(UserProfileParser.parseUserProfileMoment, response.data as String);
  }

  Future<UserProfileData> getUserProfileData(String blogName) async {
    final UserProfileInfo userProfileInfo = await userProfileApi.getUserProfile(blogName);
    final BlogDataInfo blogDataInfo = await userBlogDataApi.getBlogDataInfo(blogName);

    return UserProfileData(
      name: userProfileInfo.name,
      follow: userProfileInfo.followCounts,
      follower: userProfileInfo.followerCounts,
      comment: blogDataInfo.commentCount,
      view: blogDataInfo.viewCount,
    );
  }
}

final userProfileApi = UserProfileApi();
