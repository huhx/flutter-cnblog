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

class UserProfileMoment {
  final String name;
  final String avatar;
  final String url;
  final String action;
  final String title;
  final String summary;
  final String postDate;

  UserProfileMoment({
    required this.name,
    required this.avatar,
    required this.url,
    required this.action,
    required this.title,
    required this.summary,
    required this.postDate,
  });
}
