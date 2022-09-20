import 'package:equatable/equatable.dart';

import 'detail_model.dart';

class NewsInfo extends Equatable {
  final int id;
  final String title;
  final String url;
  final String submitter;
  final String summary;
  final String cover;
  final String homeUrl;
  final int commentCount;
  final int diggCount;
  final int viewCount;
  final DateTime postDate;

  const NewsInfo({
    required this.id,
    required this.title,
    required this.url,
    required this.submitter,
    required this.summary,
    required this.cover,
    required this.homeUrl,
    required this.commentCount,
    required this.diggCount,
    required this.viewCount,
    required this.postDate,
  });

  @override
  List<Object?> get props => [id, title, url, submitter, summary, cover, homeUrl, commentCount, diggCount, viewCount, postDate];

  Uri httpsUrl() {
    return Uri.parse("https://news.cnblogs.com$url");
  }

  String toHttps() {
    return "https://news.cnblogs.com$url";
  }

  DetailModel toDetail() {
    return DetailModel(
      id: id,
      title: title,
      url: toHttps(),
      name: submitter,
      commentCount: commentCount,
      diggCount: diggCount,
      viewCount: viewCount,
    );
  }
}

enum NewsCategory {
  lasted('最新发布', '', 30),
  recommend('推荐新闻', 'recommend', 18),
  hot('热门新闻', 'digg', 18);

  final String label;
  final String url;
  final int pageSize;

  const NewsCategory(this.label, this.url, this.pageSize);
}
