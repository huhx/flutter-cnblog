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

class BookmarkRequest {
  final String wzLinkId;
  final String url;
  final String title;
  final String tags;
  final String summary;

  const BookmarkRequest({
    required this.wzLinkId,
    required this.url,
    required this.title,
    this.tags = "",
    this.summary = "",
  });
}

class BookmarkResult extends Equatable {
  final bool success;
  final String message;

  const BookmarkResult({required this.success, required this.message});

  factory BookmarkResult.fromJson(Map<String, dynamic> json) {
    return BookmarkResult(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }

  @override
  List<Object?> get props => [success, message];
}
