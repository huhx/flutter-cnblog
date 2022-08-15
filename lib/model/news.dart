class NewsInfo {
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
  final DateTime pastDate;

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
    required this.pastDate,
  });
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
