class UserProfileInfo {
  final String name;
  final String avatar;
  final String url;
  final Map<String, String> info;
  final int followCounts;
  final int followerCounts;

  UserProfileInfo({
    required this.name,
    required this.avatar,
    required this.url,
    required this.info,
    required this.followCounts,
    required this.followerCounts,
  });
}
