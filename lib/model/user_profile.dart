import 'package:equatable/equatable.dart';
import 'package:flutter_cnblog/common/support/comm_parser.dart';

import 'detail_model.dart';

class UserProfileInfo extends Equatable {
  final String userId;
  final String name;
  final String displayName;
  final String avatar;
  final String url;
  final Map<String, String> info;
  final int followCounts;
  final int followerCounts;

  const UserProfileInfo({
    required this.userId,
    required this.name,
    required this.displayName,
    required this.avatar,
    required this.url,
    required this.info,
    required this.followCounts,
    required this.followerCounts,
  });

  @override
  List<Object?> get props => [userId, name, displayName, avatar, url, info, followCounts, followerCounts];
}

class UserProfileData extends Equatable {
  final String name;
  final int follow;
  final int follower;
  final int comment;
  final int view;

  const UserProfileData({
    required this.name,
    required this.follow,
    required this.follower,
    required this.comment,
    required this.view,
  });

  @override
  List<Object?> get props => [name, follow, follower, comment, view];
}

class UserProfileMoment extends Equatable {
  final String name;
  final String avatar;
  final String url;
  final String action;
  final String title;
  final String summary;
  final String postDate;

  const UserProfileMoment({
    required this.name,
    required this.avatar,
    required this.url,
    required this.action,
    required this.title,
    required this.summary,
    required this.postDate,
  });

  DetailModel toDetail() {
    return DetailModel(
      title: title,
      url: url,
      name: name,
      blogName: Comm.getNameFromBlogUrl(url),
      avatar: avatar,
    );
  }

  @override
  List<Object?> get props => [name, avatar, url, action, title, summary, postDate];
}
