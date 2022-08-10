import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.pascal)
class User {
  final String userId;
  final int spaceUserID;
  final int blogId;
  final String displayName;
  final String face;
  final String avatar;
  final String seniority;
  final String blogApp;

  User({
    required this.userId,
    required this.spaceUserID,
    required this.blogId,
    required this.displayName,
    required this.face,
    required this.avatar,
    required this.seniority,
    required this.blogApp,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
