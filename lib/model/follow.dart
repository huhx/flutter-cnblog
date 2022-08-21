import 'package:equatable/equatable.dart';

class FollowInfo extends Equatable {
  final String name;
  final String displayName;
  final String url;
  final String avatar;
  final DateTime followDate;

  const FollowInfo({
    required this.name,
    required this.displayName,
    required this.url,
    required this.avatar,
    required this.followDate,
  });

  @override
  List<Object?> get props => [name, displayName, url, avatar, followDate];
}

enum FollowType {
  follow('关注', 'following'),
  follower('粉丝', 'followers');

  final String label;
  final String url;

  const FollowType(this.label, this.url);
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
