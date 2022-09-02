import 'package:equatable/equatable.dart';

import 'blog_share.dart';

class DetailModel extends Equatable {
  int? id;
  final String title;
  final String url;
  final String? name;
  final String? blogName;
  final String? avatar;
  final String? html;
  final int? commentCount;
  final int? diggCount;

  DetailModel({
    this.id,
    required this.title,
    required this.url,
    this.name,
    this.blogName,
    this.avatar,
    this.html,
    this.commentCount,
    this.diggCount,
  });

  BlogShare toBlogShare() {
    return BlogShare(id: id, title: title, url: url, name: name);
  }

  @override
  List<Object?> get props => [id, title, url, name, blogName, html, commentCount, diggCount];
}
