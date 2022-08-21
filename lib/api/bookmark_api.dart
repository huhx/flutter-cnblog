import 'package:dio/dio.dart';
import 'package:flutter_cnblog/model/bookmark.dart';
import 'package:flutter_cnblog/model/bookmark_resp.dart';
import 'package:flutter_cnblog/model/follow.dart';
import 'package:flutter_cnblog/util/dio_util.dart';
import 'package:retrofit/retrofit.dart';

part 'bookmark_api.g.dart';

@RestApi(baseUrl: "https://api.cnblogs.com/api")
abstract class BookmarkApi {
  factory BookmarkApi(Dio dio) = _BookmarkApi;

  @GET("/Bookmarks")
  Future<List<BookmarkResp>> getBookmarks(@Query("pageIndex") int pageIndex, @Query("pageSize") int pageSize);

  Future<FollowResult> add(BookmarkRequest request) async {
    const String url = "https://wz.cnblogs.com/api/wz";
    final Response response = await RestClient.withCookie().post(url, data: request);

    return FollowResult.fromJson(response.data);
  }

  Future<FollowResult> update(BookmarkRequest request) async {
    const String url = "https://wz.cnblogs.com/api/wz";
    final Response response = await RestClient.withCookie().put(url, data: request);

    return FollowResult.fromJson(response.data);
  }

  Future<FollowResult> delete(String wzLinkId) async {
    final String url = "https://wz.cnblogs.com/api/wz/$wzLinkId";
    final Response response = await RestClient.withCookie().delete(url);

    return FollowResult.fromJson(response.data);
  }
}

final bookmarkApi = BookmarkApi(RestClient.getInstance());
