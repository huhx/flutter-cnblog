import 'package:equatable/equatable.dart';

class SearchInfo extends Equatable {
  final String title;
  final String url;
  final String summary;
  final String? author;
  final String? homeUrl;
  final int viewCount;
  final int? commentCount;
  final int? diggCount;
  final String postDate;

  const SearchInfo({
    required this.title,
    required this.url,
    required this.summary,
    this.author,
    this.homeUrl,
    required this.viewCount,
    this.commentCount,
    this.diggCount,
    required this.postDate,
  });

  @override
  List<Object?> get props => [title, url, summary, author, homeUrl, viewCount, commentCount, diggCount, postDate];
}

enum SearchType {
  news('新闻', 'news'),
  blog('博客', 'blogpost'),
  question('博问', 'question'),
  knowledge('知识库', 'kb'),
  my('个人搜', 'my');

  final String label;
  final String url;

  const SearchType(this.label, this.url);
}
