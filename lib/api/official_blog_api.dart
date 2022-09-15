import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/official_blog_parser.dart';
import 'package:flutter_cnblog/model/official_blog.dart';
import 'package:flutter_cnblog/util/dio_util.dart';

class OfficialBlogApi {
  Future<List<OfficialBlog>> getOfficialBlogs(int pageKey) async {
    final Dio dio = RestClient.withCookie();
    final Response response = await dio.get("https://www.cnblogs.com/cmt/default.html?page=$pageKey");

    return compute(OfficialBlogParser.parseOfficialBlogList, response.data as String);
  }
}

final officialBlogApi = OfficialBlogApi();
