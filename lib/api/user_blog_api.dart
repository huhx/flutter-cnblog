import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/user_blog_parser.dart';
import 'package:flutter_cnblog/model/user_blog.dart';

class UserBlogApi {
  Future<List<UserBlog>> getUserBlogList(int pageKey) async {
    final String url = "https://www.cnblogs.com/huhx/default.html?page=$pageKey";
    final Response response = await Dio().get(url);
    return compute(UserBlogParser.parseUserBlogList, response.data as String);
  }
}

final userBlogApi = UserBlogApi();
