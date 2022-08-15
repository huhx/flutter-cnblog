class QuestionInfo {
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
  final DateTime? pastDate;
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
    this.pastDate,
    this.answeredDate,
  });
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