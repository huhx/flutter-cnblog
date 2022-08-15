import 'package:dio/dio.dart';
import 'package:flutter_cnblog/model/instant_comment.dart';
import 'package:flutter_cnblog/util/dio_util.dart';
import 'package:retrofit/retrofit.dart';

part 'instant_comment_api.g.dart';

@RestApi(baseUrl: "https://api.cnblogs.com/api")
abstract class InstantCommentApi {
  factory InstantCommentApi(Dio dio) = _InstantCommentApi;

  @GET("/statuses/{statusId}/comments")
  Future<List<InstantComment>> getInstantComments(@Path("statusId") int statusId);
}

final instantCommentApi = InstantCommentApi(RestClient.getInstance());
