import 'package:equatable/equatable.dart';

import 'blog_share.dart';

class DetailModel extends Equatable {
  final int? id;
  final String title;
  final String url;
  final String? name;
  final String? blogName;
  final String? avatar;

  const DetailModel({
    this.id,
    required this.title,
    required this.url,
    this.name,
    this.blogName,
    this.avatar,
  });

  BlogShare toBlogShare() {
    return BlogShare(id: id, title: title, url: url, name: name);
  }

  @override
  List<Object?> get props => [id, title, url, name, blogName];
}
