import 'package:equatable/equatable.dart';
import 'package:flutter_cnblog/model/user.dart';

class FollowInfo extends Equatable {
  final String userId;
  final String name;
  final String displayName;
  final String url;
  final String avatar;
  final DateTime followDate;

  const FollowInfo({
    required this.userId,
    required this.name,
    required this.displayName,
    required this.url,
    required this.avatar,
    required this.followDate,
  });

  @override
  List<Object?> get props => [userId, name, displayName, url, avatar, followDate];

  UserInfo toUserInfo() {
    return UserInfo(avatar: avatar, displayName: displayName, blogName: name);
  }
}

enum FollowType {
  follow(0, '关注', 'following'),
  follower(1, '粉丝', 'followers');

  final int tabIndex;
  final String label;
  final String url;

  const FollowType(this.tabIndex, this.label, this.url);
}

class FollowResult extends Equatable {
  final bool isSucceed;

  const FollowResult({required this.isSucceed});

  factory FollowResult.fromJson(Map<String, dynamic> json) {
    return FollowResult(isSucceed: json['IsSucceed'] as bool);
  }

  @override
  List<Object?> get props => [isSucceed];
}
