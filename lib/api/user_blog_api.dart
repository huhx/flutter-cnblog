import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/api/blog_api.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/common/parser/blog_comment_parser.dart';
import 'package:flutter_cnblog/common/parser/blog_post_parser.dart';
import 'package:flutter_cnblog/common/parser/candidate_parser.dart';
import 'package:flutter_cnblog/common/parser/user_blog_parser.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:flutter_cnblog/model/popular_blog_resp.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:flutter_cnblog/util/dio_util.dart';
import 'package:flutter_cnblog/util/prefs_util.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

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
      data: request.toJson(),
      options: Options(headers: {"RequestVerificationToken": PrefsUtil.getForgeryToken()}),
    );
    return BlogDiggResp.fromJson(response.data);
  }

  Future<int> queryCommentCounts(String blogName, int postId) async {
    final String url = "https://www.cnblogs.com/$blogName/ajax/GetCommentCount.aspx?postId=$postId";
    final Response response = await RestClient.withCookie().get(url);

    return (response.data as String).toInt();
  }

  Future<List<BlogComment>> queryComments(String blogName, BlogCommentReq request) async {
    final String url = "https://www.cnblogs.com/$blogName/ajax/GetComments.aspx";
    final Response response = await RestClient.withCookie().get(url, queryParameters: request.toJson());

    return compute(BlogCommentParser.parseBlogCommentList, response.data as String);
  }

  Future<BlogCommentCreateResp> addComment(String blogName, BlogCommentCreateReq request) async {
    final String url = "https://www.cnblogs.com/$blogName/ajax/PostComment/Add.aspx";
    final Response response = await RestClient.withCookie().post(
      url,
      data: request.toJson(),
      options: Options(headers: {"RequestVerificationToken": PrefsUtil.getForgeryToken()}),
    );
    return BlogCommentCreateResp.fromJson(response.data);
  }

  Future<bool> updateComment(String blogName, BlogCommentUpdateReq request) async {
    final String url = "https://www.cnblogs.com/$blogName/ajax/PostComment/Update.aspx";
    final Response response = await RestClient.withCookie().post(
      url,
      data: request.toJson(),
      options: Options(headers: {"RequestVerificationToken": PrefsUtil.getForgeryToken()}),
    );
    return response.data as bool;
  }

  Future<BlogDiggResp> deleteComment(String blogName, BlogCommentDeleteReq request) async {
    final String url = "https://www.cnblogs.com/$blogName/ajax/PostComment/Update.aspx";
    final Response response = await RestClient.withCookie().post(
      url,
      data: request.toJson(),
      options: Options(headers: {"RequestVerificationToken": PrefsUtil.getForgeryToken()}),
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
      case BlogCategory.comment:
        final Response response = await Dio().get("https://www.cnblogs.com/aggsite/topcommented48h/#p$pageKey");
        return compute(CandidateParser.parseCandidateList, response.data as String);
    }
  }

  Future<BlogStat> getBlogPostStat(String blogName, int postId) async {
    final String url = "https://www.cnblogs.com/$blogName/ajax/GetPostStat";
    final Response response = await RestClient.withCookie().post(url, data: [postId]);

    return BlogStat.fromJson((response.data as List).first);
  }

  Future<BlogPostInfo> getBlogPostInfo(String blogName, BlogPostInfoReq request) async {
    final String url = "https://www.cnblogs.com/$blogName/ajax/BlogPostInfo.aspx";
    final Response response = await RestClient.withCookie().get(url, queryParameters: request.toJson());

    return compute(BlogPostInfoParser.parseBlogPostInfo, response.data as String);
  }

  Future<BlogDetailInfo> getBlogDetailInfo(String blogName, BlogPostInfoReq request) async {
    final BlogStat blogStat = await userBlogApi.getBlogPostStat(blogName, request.postId);
    final BlogPostInfo blogPostInfo = await userBlogApi.getBlogPostInfo(blogName, request);
    // final bool isMark = await bookmarkApi.isMark(url);
    // final bool isFollow = await userFollowApi.isFollow(userId);

    return BlogDetailInfo(
      isDark: false,
      commentCounts: blogStat.commentCount,
      postId: request.postId,
      isFollow: false,
      isMark: false,
      isDigg: blogPostInfo.isDigg,
      isBury: blogPostInfo.isBury,
      diggCounts: blogStat.diggCount,
      buryCounts: blogStat.buryCount,
    );
  }

  Future<String> getBlogContent(String url) async {
    final Response response = await RestClient.withCookie().get(url);

    await PrefsUtil.saveForgeryCookie(response.headers['set-cookie']?.first ?? "");
    final Document document = parse(response.data);
    final String? forgeryToken = document.getElementById("antiforgery_token")?.attributes['value']!;
    await PrefsUtil.saveForgeryToken(forgeryToken);

    return response.data;
  }
}

final userBlogApi = UserBlogApi();
