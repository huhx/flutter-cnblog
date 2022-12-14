import 'package:equatable/equatable.dart';
import 'package:flutter_cnblog/common/constant/content_type.dart';
import 'package:flutter_cnblog/common/support/comm_parser.dart';
import 'package:flutter_cnblog/model/blog_share.dart';

import 'detail_model.dart';
import 'read_log.dart';

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

  ContentType get type {
    final String hostString = Uri.parse(url).host;
    if (hostString.startsWith("news")) {
      return ContentType.news;
    }
    if (hostString.startsWith("kb")) {
      return ContentType.knowledge;
    }
    return ContentType.blog;
  }

  ReadLogType get readLogType {
    final String hostString = Uri.parse(url).host;
    if (hostString.startsWith("news")) {
      return ReadLogType.news;
    }
    if (hostString.startsWith("kb")) {
      return ReadLogType.knowledge;
    }
    return ReadLogType.blog;
  }

  BlogShare toBlogShare() {
    return BlogShare(id: id, title: title, url: url);
  }

  DetailModel toDetail({String? html}) {
    return DetailModel(
      title: title,
      url: url,
      name: "来自收藏",
      blogName: Comm.getNameFromBlogUrl(url),
      html: html,
    );
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
