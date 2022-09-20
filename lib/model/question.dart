import 'package:equatable/equatable.dart';
import 'package:flutter_cnblog/model/detail_model.dart';

import 'blog_share.dart';

class QuestionInfo extends Equatable {
  final int id;
  final String title;
  final String url;
  final String submitter;
  final String summary;
  final String avatar;
  final String homeUrl;
  final int answerCount;
  final int goldCount;
  final int viewCount;
  final DateTime? postDate;
  final DateTime? answeredDate;

  const QuestionInfo({
    required this.id,
    required this.title,
    required this.url,
    required this.submitter,
    required this.summary,
    required this.avatar,
    required this.homeUrl,
    required this.answerCount,
    required this.goldCount,
    required this.viewCount,
    this.postDate,
    this.answeredDate,
  });

  @override
  List<Object?> get props =>
      [id, title, url, submitter, summary, avatar, homeUrl, answerCount, goldCount, viewCount, postDate, answeredDate];

  Uri httpsUrl() {
    return Uri.parse("https://q.cnblogs.com$url");
  }

  String toHttps() {
    return "https://q.cnblogs.com$url";
  }

  BlogShare toBlogShare() {
    return BlogShare(id: id, title: title, url: toHttps(), name: submitter);
  }

  DetailModel toDetail() {
    return DetailModel(
      id: id,
      title: title,
      url: toHttps(),
      name: submitter,
      commentCount: answerCount,
      viewCount: viewCount,
    );
  }
}

enum QuestionStatus {
  unresolved('未解决', 'unsolved'),
  reward('高奖励', 'highscore'),
  noAnswer('零回答', 'noanswer'),
  resolved('已解决', 'solved');

  final String label;
  final String url;

  const QuestionStatus(this.label, this.url);
}

class QuestionTag {
  final String label;
  final String url;

  const QuestionTag({required this.label, required this.url});
}
