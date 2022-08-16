import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/user_profile_parser.dart';
import 'package:flutter_cnblog/model/user_profile.dart';
import 'package:flutter_cnblog/util/app_config.dart';

class UserProfileApi {
  Future<UserProfileInfo> getUserProfile(String name) async {
    final String url = "https://home.cnblogs.com/u/$name/";
    final Response response = await Dio(BaseOptions(
      headers: {
        "Cookie": ".Cnblogs.AspNetCore.Cookies=${AppConfig.get("cookie")}",
        "x-requested-with": "XMLHttpRequest",
      },
    )).get(url);
    return compute(UserProfileParser.parseUserProfile, response.data as String);
  }
}

final userProfileApi = UserProfileApi();
