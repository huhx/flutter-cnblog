import 'dart:convert';

import 'package:flutter_cnblog/model/detail_model.dart';

class ReadLog {
  final String id;
  final ReadLogType type;
  final String summary;
  final DetailModel json;
  final ReadLogStatus status;
  final int createTime;

  ReadLog({
    required this.id,
    required this.type,
    required this.summary,
    required this.json,
    required this.status,
    required this.createTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'summary': summary,
      'json': jsonEncode(json.toJson()),
      'status': status.name,
      'createTime': createTime,
    };
  }

  factory ReadLog.of({
    required ReadLogType type,
    required String summary,
    required DetailModel detailModel,
  }) {
    return ReadLog(
      id: detailModel.url,
      type: type,
      summary: summary,
      json: detailModel,
      status: ReadLogStatus.normal,
      createTime: DateTime.now().millisecondsSinceEpoch,
    );
  }

  factory ReadLog.fromJson(Map<String, dynamic> json) {
    return ReadLog(
      id: json['id'] as String,
      type: ReadLogType.values.byName(json['type'] as String),
      summary: json['summary'] as String,
      json: DetailModel.fromJson(jsonDecode(json['json'])),
      status: ReadLogStatus.values.byName(json['status'] as String),
      createTime: json['createTime'] as int,
    );
  }
}

enum ReadLogType {
  blog("博客"),
  news("新闻"),
  knowledge("文库");

  final String label;

  const ReadLogType(this.label);
}

enum ReadLogStatus { normal, delete }
