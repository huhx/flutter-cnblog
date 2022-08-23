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

  bool isNews() {
    return Uri.parse(url).host.startsWith("news");
  }

  @override
  List<Object?> get props => [id, title, url, starCounts, postDate];
}

class BookmarkRequest extends Equatable {
  final int wzLinkId;
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

  @override
  List<Object?> get props => [wzLinkId, url, title, tags, summary];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'wzLinkId': wzLinkId,
      'url': url,
      'title': title,
      'tags': tags,
      'summary': summary,
    };
  }
}

class BookmarkResult extends Equatable {
  final bool success;
  final String? message;

  const BookmarkResult({required this.success, required this.message});

  factory BookmarkResult.fromJson(Map<String, dynamic> json) {
    return BookmarkResult(
      success: json['success'] as bool,
      message: json['message'] as String?,
    );
  }

  @override
  List<Object?> get props => [success, message];
}
