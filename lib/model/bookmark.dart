import 'package:equatable/equatable.dart';

class BookmarkInfo extends Equatable {
  final int id;
  final String title;
  final String url;
  final int starCounts;
  final DateTime postDate;

  const BookmarkInfo({
    required this.id,
    required this.title,
    required this.url,
    required this.starCounts,
    required this.postDate,
  });

  @override
  List<Object?> get props => [id, title, url, starCounts, postDate];
}
