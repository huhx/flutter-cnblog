import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/api/blog_api.dart';
import 'package:flutter_cnblog/common/parser/candidate_parser.dart';
import 'package:flutter_cnblog/common/parser/user_blog_parser.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:flutter_cnblog/model/popular_blog_resp.dart';
import 'package:flutter_cnblog/model/user_blog.dart';

class UserBlogApi {
  Future<List<UserBlog>> getUserBlogList(String name, int pageKey) async {
    final String url = "https://www.cnblogs.com/$name/default.html?page=$pageKey";
    final Response response = await Dio().get(url);
    return compute(UserBlogParser.parseUserBlogList, response.data as String);
  }

  Future<List<BlogResp>> getBlogs(BlogCategory category, int pageKey) async {
    switch (category) {
      case BlogCategory.home:
        return blogApi.getHomeBlogs(pageKey, 20);
      case BlogCategory.essence:
        return blogApi.getEssenceBlogs(pageKey, 20);
      case BlogCategory.candidate:
        final Response response = await Dio().get("https://www.cnblogs.com/candidate/#p$pageKey");
        return compute(CandidateParser.parseCandidateList, response.data as String);
      case BlogCategory.read:
        final List<PopularBlogResp> data = await blogApi.getMostReadBlogs(pageKey, 20);
        return data.map((e) => e.toBlogResp()).toList();
      case BlogCategory.like:
        final List<PopularBlogResp> data = await blogApi.getMostLikedBlogs(pageKey, 20);
        return data.map((e) => e.toBlogResp()).toList();
    }
  }
}

final userBlogApi = UserBlogApi();
