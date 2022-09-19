import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'instant_comment.g.dart';

@JsonSerializable(createToJson: false)
class InstantComment extends Equatable {
  final int id;
  final int replyId;
  final String? fromName;
  final String? fromUrl;
  final String avatar;
  final String toName;
  final String toUrl;
  final String content;
  final String postDate;

  const InstantComment({
    required this.id,
    required this.replyId,
    this.fromName,
    this.fromUrl,
    required this.avatar,
    required this.toName,
    required this.toUrl,
    required this.content,
    required this.postDate,
  });

  factory InstantComment.fromJson(Map<String, dynamic> json) => _$InstantCommentFromJson(json);

  @override
  List<Object?> get props => [id, replyId, fromName, fromUrl, avatar, toName, toUrl, content, postDate];
}
