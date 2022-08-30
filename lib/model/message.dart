import 'package:equatable/equatable.dart';

import 'detail_model.dart';

class MessageInfo extends Equatable {
  final int id;
  final String author;
  final String? homeUrl;
  final String? status;
  final String title;
  final String url;
  final String postDate;

  const MessageInfo({
    required this.id,
    required this.author,
    this.homeUrl,
    this.status,
    required this.title,
    required this.url,
    required this.postDate,
  });

  DetailModel toDetail() {
    return DetailModel(id: id, title: title, url: url, name: author);
  }

  @override
  List<Object?> get props => [id, author, homeUrl, status, title, url, postDate];
}

enum MessageType {
  inbox("收件箱", "inbox"),
  outbox("发件箱", "outbox"),
  unread("未读消息", "unread");

  final String label;
  final String path;

  const MessageType(this.label, this.path);
}
