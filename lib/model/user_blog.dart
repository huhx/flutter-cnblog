import 'package:equatable/equatable.dart';

import 'blog_share.dart';

class UserBlog extends Equatable {
  final int id;
  final String dayTitle;
  final String title;
  final String url;
  final bool isPinned;
  final String summary;
  final String name;
  final int commentCount;
  final int diggCount;
  final int viewCount;
  final DateTime postDate;

  const UserBlog({
    required this.id,
    required this.dayTitle,
    required this.title,
    required this.url,
    required this.isPinned,
    required this.summary,
    required this.name,
    required this.commentCount,
    required this.diggCount,
    required this.viewCount,
    required this.postDate,
  });

  @override
  List<Object?> get props => [id, dayTitle, title, url, isPinned, summary, name, commentCount, diggCount, viewCount, postDate];

  BlogShare toBlogShare() {
    return BlogShare(id: id, title: title, url: url, name: name);
  }
}

class BlogDataInfo extends Equatable {
  final int blogCount;
  final int articleCount;
  final int commentCount;
  final int viewCount;

  const BlogDataInfo({
    required this.blogCount,
    required this.articleCount,
    required this.commentCount,
    required this.viewCount,
  });

  @override
  List<Object?> get props => [blogCount, articleCount, commentCount, viewCount];
}
