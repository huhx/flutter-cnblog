import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/api/blog_api.dart';
import 'package:flutter_cnblog/common/parser/candidate_parser.dart';
import 'package:flutter_cnblog/common/parser/user_blog_parser.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:flutter_cnblog/model/popular_blog_resp.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:flutter_cnblog/util/dio_util.dart';
import 'package:flutter_cnblog/util/prefs_util.dart';

class UserBlogApi {
  Future<List<UserBlog>> getUserBlogList(String name, int pageKey) async {
    final String url = "https://www.cnblogs.com/$name/default.html?page=$pageKey";
    final Response response = await Dio().get(url);
    return compute(UserBlogParser.parseUserBlogList, response.data as String);
  }

  Future<BlogDiggResp> diggBlog(String blogName, BlogDiggReq request) async {
    final String url = "https://www.cnblogs.com/$blogName/ajax/vote/blogpost";
    final Response response = await RestClient.withCookie().post(
      url,
      options: Options(headers: {"RequestVerificationToken": PrefsUtil.getForgeryToken()}),
      data: request.toJson(),
    );
    return BlogDiggResp.fromJson(response.data);
  }

  Future<BlogCommentResp> addComment(String blogName, BlogCommentReq request) async {
    final String url = "https://www.cnblogs.com/$blogName/ajax/PostComment/Add.aspx";
    final Response response = await RestClient.withCookie().post(
      url,
      options: Options(headers: {"RequestVerificationToken": PrefsUtil.getForgeryToken()}),
      data: request.toJson(),
    );
    return BlogCommentResp.fromJson(response.data);
  }

  Future<bool> updateComment(String blogName, BlogCommentUpdateReq request) async {
    final String url = "https://www.cnblogs.com/$blogName/ajax/PostComment/Update.aspx";
    final Response response = await RestClient.withCookie().post(
      url,
      options: Options(headers: {"RequestVerificationToken": PrefsUtil.getForgeryToken()}),
      data: request.toJson(),
    );
    return response.data as bool;
  }

  Future<BlogDiggResp> deleteComment(String blogName, BlogCommentDeleteReq request) async {
    final String url = "https://www.cnblogs.com/$blogName/ajax/PostComment/Update.aspx";
    final Response response = await RestClient.withCookie().post(
      url,
      options: Options(headers: {"RequestVerificationToken": PrefsUtil.getForgeryToken()}),
      data: request.toJson(),
    );
    return BlogDiggResp.fromJson(response.data);
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
