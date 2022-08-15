import 'package:json_annotation/json_annotation.dart';

part 'instant_comment.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.pascal)
class InstantComment {
  final int id;
  final String content;
  final int statusId;
  final String userAlias;
  final String userDisplayName;
  final String userIconUrl;
  final int userId;
  final DateTime dateAdded;

  InstantComment({
    required this.id,
    required this.content,
    required this.statusId,
    required this.userAlias,
    required this.userDisplayName,
    required this.userIconUrl,
    required this.userId,
    required this.dateAdded,
  });

  factory InstantComment.fromJson(Map<String, dynamic> json) => _$InstantCommentFromJson(json);
}
