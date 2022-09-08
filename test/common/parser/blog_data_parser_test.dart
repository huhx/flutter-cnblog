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

  test("should return blog data info when another style1", () {
    const String string = '''
    <body>随笔 -
    102&nbsp;
    文章 -
    0&nbsp;
    评论 -
    47&nbsp;
    阅读 - 
    
    <span title="总阅读数: 52852">
    52852</span>
    </body>
  ''';

    final BlogDataInfo blogDataInfo = BlogDataParser.parseBlogDataList(string);

    expect(
      blogDataInfo,
      const BlogDataInfo(blogCount: 102, articleCount: 0, commentCount: 47, viewCount: 52852),
    );
  });


  test("should return blog data info when another style2", () {
    const String string = '''
    <body><!--done-->
    随笔- 109&nbsp;
    文章- 0&nbsp;
    评论- 620&nbsp;
    阅读- 
    <span title="总阅读数: 214198">
    21万</span>&nbsp;
    </body>
  ''';

    final BlogDataInfo blogDataInfo = BlogDataParser.parseBlogDataList(string);

    expect(
      blogDataInfo,
      const BlogDataInfo(blogCount: 109, articleCount: 0, commentCount: 620, viewCount: 214198),
    );
  });
}
