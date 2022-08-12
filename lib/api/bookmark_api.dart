import 'package:dio/dio.dart';
import 'package:flutter_cnblog/model/bookmark_resp.dart';
import 'package:flutter_cnblog/util/dio_util.dart';
import 'package:retrofit/retrofit.dart';

part 'bookmark_api.g.dart';

@RestApi(baseUrl: "https://api.cnblogs.com/api")
abstract class BookmarkApi {
  factory BookmarkApi(Dio dio) = _BookmarkApi;

  @GET("/Bookmarks")
  Future<List<BookmarkResp>> getBookmarks(@Query("pageIndex") int pageIndex, @Query("pageSize") int pageSize);
}

final bookmarkApi = BookmarkApi(RestClient.getInstance());
