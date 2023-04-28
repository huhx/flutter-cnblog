import 'package:equatable/equatable.dart';
import 'package:flutter_cnblog/common/support/comm_parser.dart';
import 'package:flutter_cnblog/model/detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'blog_share.dart';

part 'blog_resp.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.pascal)
class BlogResp extends Equatable {
  final int id;
  final String title;
  final String url;
  final String description;
  final String author;
  final String? avatar;
  final DateTime postDate;
  final int viewCount;
  final int commentCount;
  final int diggCount;

  const BlogResp({
    required this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.author,
    this.avatar,
    required this.postDate,
    required this.viewCount,
    required this.commentCount,
    required this.diggCount,
  });

  String toHttps() {
    return Uri.parse(url).replace(scheme: "https").toString();
  }

  factory BlogResp.fromJson(Map<String, dynamic> json) => _$BlogRespFromJson(json);

  @override
  List<Object?> get props => [id, title, url, description, author, avatar, postDate, viewCount, commentCount, diggCount];

  DetailModel toDetail({String? html}) {
    final String httpsUrl = toHttps();
    return DetailModel(
      id: id,
      title: title,
      avatar: avatar,
      url: httpsUrl,
      name: author,
      blogName: Comm.getNameFromBlogUrl(httpsUrl),
      commentCount: commentCount,
      diggCount: diggCount,
      viewCount: viewCount,
      html: html,
    );
  }

  BlogShare toBlogShare() {
    return BlogShare(id: id, title: title, url: toHttps(), name: author);
  }
}

class BasicBlogInfo extends Equatable {
  final int id;
  final String title;
  final String avatar;
  final String url;
  final String? author;

  const BasicBlogInfo({
    required this.id,
    required this.title,
    required this.avatar,
    required this.url,
    this.author,
  });

  @override
  List<Object?> get props => [id, title, url, author, avatar];

  BlogShare toBlogShare() {
    return BlogShare(id: id, title: title, url: url, name: author);
  }

  String toHttps() {
    return Uri.parse(url).replace(scheme: "https").toString();
  }
}

enum BlogCategory {
  home(""),
  read(""),
  comment(""),
  like(""),
  essence(""),
  candidate("");

  final String url;

  const BlogCategory(this.url);
}
