import 'dart:convert';

import 'package:flutter_cnblog/model/detail_model.dart';

class ReadLog {
  final int? id;
  final ReadLogType type;
  final int startTime;
  final int endTime;
  final int duration;
  final DetailModel json;
  final ReadLogStatus status;
  final int createTime;

  ReadLog({
    this.id,
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.json,
    required this.status,
    required this.createTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'startTime': startTime,
      'endTime': endTime,
      'duration': duration,
      'json': jsonEncode(json.toJson()),
      'status': status.name,
      'createTime': createTime,
    };
  }

  factory ReadLog.fromJson(Map<String, dynamic> json) {
    return ReadLog(
      id: json['id'] as int?,
      type: ReadLogType.values.byName(json['type'] as String),
      startTime: json['startTime'] as int,
      endTime: json['endTime'] as int,
      duration: json['duration'] as int,
      json: DetailModel.fromJson(json['json'] as Map<String, dynamic>),
      status: ReadLogStatus.values.byName(json['status'] as String),
      createTime: json['createTime'] as int,
    );
  }
}

enum ReadLogType { blog, news, knowledge }

enum ReadLogStatus { normal, delete }
