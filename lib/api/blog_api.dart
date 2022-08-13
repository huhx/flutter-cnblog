import 'package:dio/dio.dart';
import 'package:flutter_cnblog/model/blog_content_resp.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:flutter_cnblog/model/popular_blog_resp.dart';
import 'package:flutter_cnblog/model/recommend_blog_resp.dart';
import 'package:flutter_cnblog/util/dio_util.dart';
import 'package:retrofit/retrofit.dart';

part 'blog_api.g.dart';

@RestApi(baseUrl: "https://api.cnblogs.com/api")
abstract class BlogApi {
  factory BlogApi(Dio dio) = _BlogApi;

  @GET("/blogposts/@sitehome")
  Future<List<BlogResp>> getHomeBlogs(@Query("pageIndex") int pageIndex, @Query("pageSize") int pageSize);

  @GET("/blogposts/@picked")
  Future<List<BlogResp>> getEssenceBlogs(@Query("pageIndex") int pageIndex, @Query("pageSize") int pageSize);

  @GET("/blog/v2/blogposts/url/{url}")
  Future<BlogContentResp> getBlogByUrl(@Path("url") String url);

  @GET("/blogposts/{id}/body")
  Future<String> getBlogContent(@Path("id") int id);

  @GET("/blog/v2/blogposts/aggsites/mostread")
  Future<List<PopularBlogResp>> getMostReadBlogs(@Query("pageIndex") int pageIndex, @Query("pageSize") int pageSize);

  @GET("/blog/v2/blogposts/aggsites/mostliked")
  Future<List<PopularBlogResp>> getMostLikedBlogs(@Query("pageIndex") int pageIndex, @Query("pageSize") int pageSize);

  @GET("/blog/v2/blogposts/aggsites/headline")
  Future<List<RecommendBlogResp>> getRecommendBlogs(@Query("pageIndex") int pageIndex, @Query("pageSize") int pageSize);
}

final blogApi = BlogApi(RestClient.getInstance());
