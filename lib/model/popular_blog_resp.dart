import 'package:flutter_cnblog/common/support/comm_parser.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popular_blog_resp.g.dart';

@JsonSerializable(createToJson: false)
class PopularBlogResp {
  final int id;
  final int blogId;
  final String title;
  final String url;
  final String blogUrl;
  final String description;
  final String author;
  final String? avatar;
  final int postType;
  final int postConfig;
  final int viewCount;
  final int commentCount;
  final int diggCount;
  final DateTime dateAdded;
  final DateTime dateUpdated;
  final String? entryName;

  PopularBlogResp({
    required this.id,
    required this.blogId,
    required this.title,
    required this.url,
    required this.blogUrl,
    required this.description,
    required this.author,
    this.avatar,
    required this.postType,
    required this.postConfig,
    required this.viewCount,
    required this.commentCount,
    required this.diggCount,
    required this.dateAdded,
    required this.dateUpdated,
    this.entryName,
  });

  factory PopularBlogResp.fromJson(Map<String, dynamic> json) => _$PopularBlogRespFromJson(json);

  BlogResp toBlogResp() {
    return BlogResp(
      id: id,
      title: title,
      url: url,
      description: description,
      author: author,
      blogApp: Comm.getNameFromBlogUrl(url),
      avatar: avatar ?? '',
      postDate: dateAdded,
      viewCount: viewCount,
      commentCount: commentCount,
      diggCount: diggCount,
    );
  }
}
