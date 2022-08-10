import 'package:json_annotation/json_annotation.dart';

part 'blog_resp.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.pascal)
class BlogResp {
  final int id;
  final String title;
  final String url;
  final String description;
  final String author;
  final String blogApp;
  final String avatar;
  final String postDate;
  final int viewCount;
  final int commentCount;
  final int diggCount;

  BlogResp({
    required this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.author,
    required this.blogApp,
    required this.avatar,
    required this.postDate,
    required this.viewCount,
    required this.commentCount,
    required this.diggCount,
  });

  factory BlogResp.fromJson(Map<String, dynamic> json) => _$BlogRespFromJson(json);
}
