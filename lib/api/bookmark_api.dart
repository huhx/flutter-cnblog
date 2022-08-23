import 'package:dio/dio.dart';
import 'package:flutter_cnblog/common/parser/bookmark_parser.dart';
import 'package:flutter_cnblog/model/bookmark.dart';
import 'package:flutter_cnblog/util/dio_util.dart';

class BookmarkApi {
  Future<BookmarkResult> add(BookmarkRequest request) async {
    const String url = "https://wz.cnblogs.com/api/wz";
    final Response response = await RestClient.withCookie().post(url, data: request);

    return BookmarkResult.fromJson(response.data);
  }

  Future<bool> isMark(String bookmarkUrl) async {
    final String url = "https://wz.cnblogs.com/create?u=${Uri.encodeComponent(bookmarkUrl)}";
    final Response response = await RestClient.withCookie().get(url);

    return BookmarkParser.isMark(response.data as String);
  }

  Future<BookmarkResult> update(BookmarkRequest request) async {
    const String url = "https://wz.cnblogs.com/api/wz";
    final Response response = await RestClient.withCookie().put(url, data: request);

    return BookmarkResult.fromJson(response.data);
  }

  Future<BookmarkResult> delete(String wzLinkId) async {
    final String url = "https://wz.cnblogs.com/api/wz/$wzLinkId";
    final Response response = await RestClient.withCookie().delete(url);

    return BookmarkResult.fromJson(response.data);
  }
}

final bookmarkApi = BookmarkApi();
