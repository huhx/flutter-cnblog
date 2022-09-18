import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'blog_share.dart';
import 'user.dart';

part 'detail_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class DetailModel extends Equatable {
  final int? id;
  final String title;
  final String url;
  final String? name;
  final String? blogName;
  final String? avatar;
  final String? html;
  final int? commentCount;
  final int? diggCount;

  const DetailModel({
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

  Map<String, dynamic> toJson() => _$DetailModelToJson(this);

  factory DetailModel.fromJson(Map<String, dynamic> json) => _$DetailModelFromJson(json);

  BlogShare toBlogShare() {
    return BlogShare(id: id, title: title, url: url, name: name);
  }

  DetailModel copyWith({required int postId}) {
    return DetailModel(
      id: postId,
      title: title,
      url: url,
      name: name,
      blogName: blogName,
      avatar: avatar,
      html: html,
      commentCount: commentCount,
      diggCount: diggCount,
    );
  }

  UserInfo toUserInfo() {
    return UserInfo(avatar: avatar ?? '', displayName: name!, blogName: blogName!);
  }

  @override
  List<Object?> get props => [id, title, url, name, blogName, html, commentCount, diggCount];
}
