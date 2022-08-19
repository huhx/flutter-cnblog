import 'package:equatable/equatable.dart';

class KnowledgeInfo extends Equatable {
  final int id;
  final String title;
  final String url;
  final String summary;
  final String category;
  final List<String> tags;
  final DateTime postDate;
  final int viewCount;
  final int diggCount;

  const KnowledgeInfo({
    required this.id,
    required this.title,
    required this.url,
    required this.summary,
    required this.category,
    required this.tags,
    required this.postDate,
    required this.viewCount,
    required this.diggCount,
  });

  @override
  List<Object?> get props => [id, title, url, summary, category, tags, postDate, viewCount, diggCount];
}