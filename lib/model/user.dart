import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
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

  Map<String, dynamic> toJson() => _$UserToJson(this);

  UserInfo toInfo() {
    return UserInfo(displayName: displayName, avatar: avatar, blogName: blogApp);
  }
}

class UserInfo {
  final String displayName;
  final String avatar;
  final String blogName;

  UserInfo({
    required this.displayName,
    required this.avatar,
    required this.blogName,
  });
}
