import 'package:flutter_cnblog/common/support/comm_parser.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blog_content_resp.g.dart';

@JsonSerializable(createToJson: false)
class BlogContentResp {
  final int id;
  final int blogId;
  final String title;
  final String url;
  final String description;
  final String author;
  final String? avatar;
  final String blogApp;

  final int viewCount;
  final int commentCount;
  final int diggCount;
  final DateTime dateAdded;
  final DateTime dateUpdated;
  final String body;
  final List<String>? tags;
  final List<String>? categories;

  BlogContentResp({
    required this.id,
    required this.blogId,
    required this.title,
    required this.url,
    required this.description,
    required this.author,
    this.avatar,
    required this.blogApp,
    required this.viewCount,
    required this.commentCount,
    required this.diggCount,
    required this.dateAdded,
    required this.dateUpdated,
    required this.body,
    this.tags,
    this.categories
  });

  factory BlogContentResp.fromJson(Map<String, dynamic> json) => _$BlogContentRespFromJson(json);

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
