import 'package:equatable/equatable.dart';

class UserProfileInfo extends Equatable {
  final String name;
  final String avatar;
  final String url;
  final Map<String, String> info;
  final int followCounts;
  final int followerCounts;

  const UserProfileInfo({
    required this.name,
    required this.avatar,
    required this.url,
    required this.info,
    required this.followCounts,
    required this.followerCounts,
  });

  @override
  List<Object?> get props => [name, avatar, url, info, followCounts, followerCounts];
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

  @override
  List<Object?> get props => [name, avatar, url, action, title, summary, postDate];
}
