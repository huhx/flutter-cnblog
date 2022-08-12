import 'package:json_annotation/json_annotation.dart';

part 'bookmark_resp.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.pascal)
class BookmarkResp {
  final int wzLinkId;
  final String title;
  final String linkUrl;
  final List<String> tags;
  final DateTime dateAdded;
  final bool fromCNBlogs;

  BookmarkResp({
    required this.wzLinkId,
    required this.title,
    required this.linkUrl,
    required this.tags,
    required this.dateAdded,
    required this.fromCNBlogs,
  });

  factory BookmarkResp.fromJson(Map<String, dynamic> json) => _$BookmarkRespFromJson(json);
}
