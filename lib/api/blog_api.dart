import 'package:dio/dio.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:flutter_cnblog/util/dio_util.dart';
import 'package:retrofit/retrofit.dart';

part 'blog_api.g.dart';

@RestApi(baseUrl: "https://api.cnblogs.com/api")
abstract class BlogApi {
  factory BlogApi(Dio dio) = _BlogApi;

  @GET("/blogposts/@sitehome")
  Future<List<BlogResp>> getHomeBlogs(@Query("pageIndex") int pageIndex, @Query("pageSize") int pageSize);

  @GET("/blogposts/{id}/body")
  Future<String> getBlogContent(@Path("id") int id);
}

final blogApi = BlogApi(RestClient.getInstance());
