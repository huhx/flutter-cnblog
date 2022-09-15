import 'package:equatable/equatable.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/common/support/comm_parser.dart';
import 'package:flutter_cnblog/model/user.dart';

import 'detail_model.dart';

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

  DetailModel toDetail() {
    return DetailModel(
      id: id.toInt(),
      title: title,
      avatar: null,
      url: url,
      name: "博客园官方",
      blogName: Comm.getNameFromBlogUrl(url),
      commentCount: commentCount,
      diggCount: diggCount,
    );
  }
}

class OfficialHot extends Equatable {
  final int id;
  final String title;
  final String url;
  final String name;
  final String? homeUrl;
  final bool isBlog;

  const OfficialHot({
    required this.id,
    required this.title,
    required this.url,
    required this.name,
    this.homeUrl,
    required this.isBlog,
  });

  @override
  List<Object?> get props => [id, title, url, name, homeUrl, isBlog];

  DetailModel toDetail() {
    return DetailModel(
      id: id.toInt(),
      title: title,
      avatar: null,
      url: url,
      name: name,
      blogName: Comm.getNameFromBlogUrl(url),
    );
  }

  UserInfo toInfo() {
    return UserInfo(displayName: name, avatar: "", blogName: Comm.getNameFromBlogUrl(url));
  }
}
