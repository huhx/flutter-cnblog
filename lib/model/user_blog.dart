import 'package:equatable/equatable.dart';

import 'blog_share.dart';

class UserBlog extends Equatable {
  final int id;
  final String dayTitle;
  final String title;
  final String url;
  final bool isPinned;
  final String summary;
  final String name;
  final int commentCount;
  final int diggCount;
  final int viewCount;
  final DateTime postDate;

  const UserBlog({
    required this.id,
    required this.dayTitle,
    required this.title,
    required this.url,
    required this.isPinned,
    required this.summary,
    required this.name,
    required this.commentCount,
    required this.diggCount,
    required this.viewCount,
    required this.postDate,
  });

  @override
  List<Object?> get props => [id, dayTitle, title, url, isPinned, summary, name, commentCount, diggCount, viewCount, postDate];

  BlogShare toBlogShare() {
    return BlogShare(id: id, title: title, url: url, name: name);
  }
}

class BlogDataInfo extends Equatable {
  final int blogCount;
  final int articleCount;
  final int commentCount;
  final int viewCount;

  const BlogDataInfo({
    required this.blogCount,
    required this.articleCount,
    required this.commentCount,
    required this.viewCount,
  });

  @override
  List<Object?> get props => [blogCount, articleCount, commentCount, viewCount];
}

enum VoteType {
  digg("Digg"),
  bury("Bury");

  final String text;

  const VoteType(this.text);
}

class BlogDiggReq extends Equatable {
  final int postId;
  final bool isAbandoned;
  final VoteType voteType;

  const BlogDiggReq({
    required this.postId,
    required this.isAbandoned,
    required this.voteType,
  });

  @override
  List<Object?> get props => [postId, isAbandoned, voteType];

  Map<String, dynamic> toJson() {
    return {"postId": postId, "isAbandoned": isAbandoned, "voteType": voteType.text};
  }
}

class BlogCommentReq extends Equatable {
  final int postId;
  final String body;
  final int parentCommentId;

  const BlogCommentReq({
    required this.postId,
    required this.body,
    required this.parentCommentId,
  });

  @override
  List<Object?> get props => [postId, body, parentCommentId];

  Map<String, dynamic> toJson() {
    return {"postId": postId, "body": body, "parentCommentId": parentCommentId};
  }
}

class BlogCommentUpdateReq extends Equatable {
  final String body;
  final int commentId;

  const BlogCommentUpdateReq({
    required this.body,
    required this.commentId,
  });

  @override
  List<Object?> get props => [body, commentId];

  Map<String, dynamic> toJson() {
    return {"body": body, "commentId": commentId};
  }
}

class BlogCommentDeleteReq extends Equatable {
  final int pageIndex;
  final int parentId;
  final int commentId;

  const BlogCommentDeleteReq({
    required this.pageIndex,
    required this.parentId,
    required this.commentId,
  });

  @override
  List<Object?> get props => [pageIndex, parentId, commentId];

  Map<String, dynamic> toJson() {
    return {"pageIndex": pageIndex, "parentId": parentId, "commentId": commentId};
  }
}

class BlogCommentResp extends Equatable {
  final bool isSuccess;
  final String message;
  final String? duration;

  const BlogCommentResp({
    required this.isSuccess,
    required this.message,
    this.duration,
  });

  @override
  List<Object?> get props => [isSuccess, message, duration];

  factory BlogCommentResp.fromJson(Map<String, dynamic> json) {
    return BlogCommentResp(
      isSuccess: json['isSuccess'] as bool,
      message: json['message'] as String,
      duration: json['duration'] as String?,
    );
  }
}

class BlogDiggResp extends Equatable {
  final int id;
  final bool isSuccess;
  final String message;
  final String? data;

  const BlogDiggResp({
    required this.id,
    required this.isSuccess,
    required this.message,
    this.data,
  });

  @override
  List<Object?> get props => [id, isSuccess, message, data];

  factory BlogDiggResp.fromJson(Map<String, dynamic> json) {
    return BlogDiggResp(
      id: json['id'] as int,
      isSuccess: json['IsSucceed'] as bool,
      message: json['message'] as String,
      data: json['data'] as String?,
    );
  }
}
