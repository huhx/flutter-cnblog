import 'package:equatable/equatable.dart';

class OfficialBlog extends Equatable {
  final String id;
  final String title;
  final String url;
  final String summary;
  final bool isReview;
  final String postDate;
  final int viewCount;
  final int commentCount;
  final int diggCount;

  const OfficialBlog({
    required this.id,
    required this.title,
    required this.url,
    required this.summary,
    required this.isReview,
    required this.postDate,
    required this.viewCount,
    required this.commentCount,
    required this.diggCount,
  });

  @override
  List<Object?> get props => [id, title, url, summary, isReview, postDate, viewCount, commentCount, diggCount];
}
