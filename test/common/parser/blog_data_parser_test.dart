import 'package:flutter_cnblog/common/parser/blog_data_parser.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return blog data info", () {
    const String string = '''
    <body>
      <span id="stats_post_count">随笔 - 267&nbsp; </span>
      <span id="stats_article_count">文章 - 11&nbsp; </span>
      <span id="stats-comment_count">评论 - 138&nbsp; </span>
      <span id="stats-total-view-count">阅读 - <span title="总阅读数: 679035"> 67万</span></span>
    </body>
  ''';

    final BlogDataInfo blogDataInfo = BlogDataParser.parseBlogDataList(string);

    expect(
      blogDataInfo,
      const BlogDataInfo(blogCount: 267, articleCount: 11, commentCount: 138, viewCount: 679035),
    );
  });
}
