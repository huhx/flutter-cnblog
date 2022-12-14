import 'package:equatable/equatable.dart';

class CommentResp extends Equatable {
  final int id;
  final bool isSuccess;
  final String message;
  final String? data;

  const CommentResp({
    required this.id,
    required this.isSuccess,
    required this.message,
    this.data,
  });

  @override
  List<Object?> get props => [id, isSuccess, message, data];

  factory CommentResp.fromJson(Map<String, dynamic> json) {
    return CommentResp(
      id: json['id'] as int,
      isSuccess: json['isSuccess'] as bool,
      message: json['message'] as String,
      data: json['data'] as String?,
    );
  }
}

class InstantCommentReq {
  final String content;
  final int ingId;
  final int parentCommentId;

  const InstantCommentReq({
    required this.content,
    required this.ingId,
    required this.parentCommentId,
  });

  Map<String, dynamic> toJson() {
    return {
      'Content': content,
      'IngId': ingId,
      'ParentCommentId': parentCommentId,
    };
  }
}

class InstantCommentDeleteReq {
  final int commentId;

  const InstantCommentDeleteReq({
    required this.commentId,
  });

  Map<String, dynamic> toJson() {
    return {'commentId': commentId};
  }
}

enum InstantFlag {
  public(1),
  private(0);

  final int value;

  const InstantFlag(this.value);
}

class InstantReq extends Equatable {
  final String content;
  final InstantFlag instantFlag;

  const InstantReq({
    required this.content,
    required this.instantFlag,
  });

  Map<String, dynamic> toJson() {
    return {'content': content, 'publicFlag': instantFlag.value};
  }

  @override
  List<Object?> get props => [content, instantFlag];
}

class InstantDeleteReq {
  final int ingId;

  const InstantDeleteReq({
    required this.ingId,
  });

  Map<String, dynamic> toJson() {
    return {'ingId': ingId};
  }
}

class InstantResp {
  final bool isSuccess;
  final String responseText;

  const InstantResp({
    required this.isSuccess,
    required this.responseText,
  });

  factory InstantResp.fromJson(Map<String, dynamic> json) {
    return InstantResp(
      isSuccess: json['isSuccess'] as bool,
      responseText: json['responseText'] as String,
    );
  }
}
