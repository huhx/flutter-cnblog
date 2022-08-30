import 'package:dio/dio.dart';
import 'package:flutter_cnblog/model/comment.dart';
import 'package:flutter_cnblog/util/dio_util.dart';
import 'package:retrofit/retrofit.dart';

part 'user_instant_api.g.dart';

@RestApi(baseUrl: "https://ing.cnblogs.com")
abstract class UserInstantApi {
  factory UserInstantApi(Dio dio) = _UserInstantApi;

  @POST("/ajax/ing/Publish")
  Future<InstantResp> postInstant(@Body() InstantReq request);

  @POST("/ajax/ing/del")
  Future<String> deleteInstant(@Body() InstantDeleteReq request);


  @POST("/ajax/ing/PostComment")
  Future<CommentResp> postInstantComment(@Body() InstantCommentReq request);

  @POST("/ajax/ing/DeleteComment")
  Future<CommentResp> deleteInstantComment(@Body() InstantCommentDeleteReq request);
}

final userInstantApi = UserInstantApi(RestClient.withCookie());
