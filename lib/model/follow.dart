class FollowInfo {
  final String name;
  final String displayName;
  final String url;
  final String avatar;
  final DateTime followDate;

  FollowInfo({
    required this.name,
    required this.displayName,
    required this.url,
    required this.avatar,
    required this.followDate,
  });
}

enum FollowType {
  follow('关注', 'following'),
  follower('粉丝', 'followers');

  final String label;
  final String url;

  const FollowType(this.label, this.url);
}
