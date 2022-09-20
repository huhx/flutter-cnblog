import 'package:equatable/equatable.dart';
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
  final String blogApp;
  final String avatar;
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
    required this.blogApp,
    required this.avatar,
    required this.postDate,
    required this.viewCount,
    required this.commentCount,
    required this.diggCount,
  });

  Uri httpsUrl() {
    return Uri.parse(url).replace(scheme: "https");
  }

  String toHttps() {
    return httpsUrl().toString();
  }

  factory BlogResp.fromJson(Map<String, dynamic> json) => _$BlogRespFromJson(json);

  @override
  List<Object?> get props => [id, title, url, description, author, blogApp, avatar, postDate, viewCount, commentCount, diggCount];

  DetailModel toDetail({String? html}) {
    return DetailModel(
      id: id,
      title: title,
      avatar: avatar,
      url: toHttps(),
      name: author,
      blogName: blogApp,
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

  Uri httpsUrl() {
    return Uri.parse(url).replace(scheme: "https");
  }

  String toHttps() {
    return httpsUrl().toString();
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
