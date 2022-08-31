import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/instant_comment_parser.dart';
import 'package:flutter_cnblog/model/comment.dart';
import 'package:flutter_cnblog/model/instant_comment.dart';
import 'package:flutter_cnblog/util/dio_util.dart';

class UserInstantApi {
  static const String baseUrl = "https://ing.cnblogs.com/ajax";

  Future<InstantResp> postInstant(InstantReq request) async {
    const String url = "$baseUrl/ing/Publish";
    final FormData formData = FormData.fromMap(request.toJson());
    final Response response = await RestClient.withCookie().post(url, data: formData);

    return InstantResp.fromJson(response.data);
  }

  Future<String> deleteInstant(InstantDeleteReq request) async {
    const String url = "$baseUrl/ing/del";
    final FormData formData = FormData.fromMap(request.toJson());
    final Response response = await RestClient.withCookie().post(url, data: formData);

    return response.data;
  }

  Future<List<InstantComment>> getInstantComments(int instantId) async {
    final String url = "$baseUrl/ing/SingleIngComments?ingId=$instantId";
    final Response response = await RestClient.withCookie().get(url);

    return compute(InstantCommentParser.parseInstantCommentList, response.data as String);
  }

  Future<CommentResp> postInstantComment(InstantCommentReq request) async {
    const String url = "$baseUrl/ing/PostComment";
    final Response response = await RestClient.withCookie().post(url, data: request.toJson());

    return CommentResp.fromJson(response.data);
  }

  Future<CommentResp> deleteInstantComment(InstantCommentDeleteReq request) async {
    const String url = "$baseUrl/ing/DeleteComment";
    final FormData formData = FormData.fromMap(request.toJson());
    final Response response = await RestClient.withCookie().post(url, data: formData);

    return CommentResp.fromJson(response.data);
  }
}

final userInstantApi = UserInstantApi();
