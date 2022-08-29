import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/blog_data_parser.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:flutter_cnblog/util/dio_util.dart';

class UserBlogDataApi {
  Future<BlogDataInfo> getBlogDataInfo(String name) async {
    final String url = "https://www.cnblogs.com/$name/ajax/blogStats";
    final Response response = await RestClient.withCookie().get(url);

    return compute(BlogDataParser.parseBlogDataList, response.data as String);
  }
}

final userBlogDataApi = UserBlogDataApi();
