import 'package:json_annotation/json_annotation.dart';

part 'recommend_blog_resp.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.none)
class RecommendBlogResp {
  final int postId;
  final int blogId;
  final String title;
  final DateTime dateAdded;

  RecommendBlogResp({
    required this.postId,
    required this.blogId,
    required this.title,
    required this.dateAdded,
  });

  factory RecommendBlogResp.fromJson(Map<String, dynamic> json) => _$RecommendBlogRespFromJson(json);
}
