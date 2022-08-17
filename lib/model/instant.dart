import 'package:equatable/equatable.dart';

import 'instant_comment.dart';

class InstantInfo extends Equatable {
  final int id;
  final String content;
  final String url;
  final String submitter;
  final String avatar;
  final String homeUrl;
  final String postDate;
  final int commentCounts;
  final List<InstantComment> comments;

  const InstantInfo({
    required this.id,
    required this.content,
    required this.url,
    required this.submitter,
    required this.avatar,
    required this.homeUrl,
    required this.postDate,
    required this.commentCounts,
    required this.comments,
  });

  @override
  List<Object?> get props => [id, content, url, submitter, avatar, homeUrl, postDate, commentCounts, comments];
}

enum InstantCategory {
  all('全部', 'All'),
  newComment('新回复', 'RecentComment'),
  following('我的关注', 'Following');

  final String label;
  final String url;

  const InstantCategory(this.label, this.url);
}

enum MyInstantCategory {
  comment('回复我', 'comment'),
  mention('提到我', 'mention'),
  publish('我发布', 'publish');

  final String label;
  final String url;

  const MyInstantCategory(this.label, this.url);
}
