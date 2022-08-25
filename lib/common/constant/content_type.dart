enum ContentType {
  news('news_css', 'https://news.cnblogs.com'),
  blog('blog_css', 'https://www.cnblogs.com'),
  knowledge('knowledge_css', 'https://kb.cnblogs.com'),
  message('message_css', 'https://msg.cnblogs.com'),
  myQuestion('my_question_css', 'https://q.cnblogs.com'),
  question('question_css', 'https://q.cnblogs.com');

  final String css;
  final String host;

  const ContentType(this.css, this.host);
}
