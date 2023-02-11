import 'package:flutter_cnblog/common/parser/blog_comment_parser.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return blog comment list", () {
    const String string = '''
  <div>
    <div class="feedbackNoItems">
        <div class="feedbackNoItems"></div>
    </div>
     <div class="feedbackItem">
        <div class="feedbackListSubtitle">
            <div class="feedbackManage">
                <span class="comment_actions">
                    <a href="javascript:void(0);"
                        onclick="return ReplyComment(5095633, 'H&#x2B;5LokWy96mGt7KjYMkRlE5sBFTRzrJd9OzA670EVTgztE2EEtMnaA==')">
                        回复
                    </a>
                    <a href="javascript:void(0);"
                        onclick="return QuoteComment(5095633, 'H&#x2B;5LokWy96mGt7KjYMkRlE5sBFTRzrJd9OzA670EVTgztE2EEtMnaA==')">
                        引用
                    </a>
                </span>
            </div>
            <a href="#5095633" class="layer">#1楼</a>
            <a name="5095633" id="comment_anchor_5095633"></a>
            <span class="comment_date">2022-08-29 15:30</span>
            <a id="a_comment_author_5095633" href="https://home.cnblogs.com/u/797377/" target="_blank">some-body</a>
        </div>
        <div class="feedbackCon">
            <div id="comment_body_5095633" data-format-type="Markdown" class="blog_comment_body cnblogs-markdown">
                <p>我像是差这3w的人吗？</p>
            </div>
            <div class="comment_vote">
                <span class="comment_error" style="color: red"></span>
                <a href="javascript:void(0);" class="comment_digg"
                    onclick="return voteComment(5095633, 'Digg', this.parentElement, false);">
                    支持(2)
                </a>
                <a href="javascript:void(0);" class="comment_burry"
                    onclick="return voteComment(5095633, 'Bury', this.parentElement, false);">
                    反对(0)
                </a>
            </div>
        </div>
    </div>
    <div class="feedbackItem">
        <div class="feedbackListSubtitle">
            <div class="feedbackManage">
                <span class="comment_actions">
                    <a href="javascript:void(0);"
                        onclick="return ReplyComment(5096460, 'o43e3oVfSqcowFHjawnKoho4ZlZS3Agk&#x2B;TCS2jvKTih9/&#x2B;Hf/gl7sg==')">
                        回复
                    </a>
                    <a href="javascript:void(0);"
                        onclick="return QuoteComment(5096460, 'o43e3oVfSqcowFHjawnKoho4ZlZS3Agk&#x2B;TCS2jvKTih9/&#x2B;Hf/gl7sg==')">
                        引用
                    </a>
                </span>
            </div>
            <a href="#5096460" class="layer">#4楼</a>
            <a name="5096460" id="comment_anchor_5096460"></a>
            <span id="comment-maxId" style="display: none">5096460</span>
            <span id="comment-maxDate" style="display: none">8/31/2022 3:39:28 PM</span>
            <span class="comment_date">2022-08-31 15:39</span>
            <a id="a_comment_author_5096460" href="https://home.cnblogs.com/u/2961804/" target="_blank">一二三。</a>
        </div>
        <div class="feedbackCon">
            <div id="comment_body_5096460" data-format-type="Markdown" class="blog_comment_body cnblogs-markdown">
                <p><a href="#5095633" title="查看所回复的评论"
                        onclick='commentManager.renderComments(0,50,5095633);'>@</a>some-body<br>
                    啊</p>
            </div>
            <div class="comment_vote">
                <span class="comment_error" style="color: red"></span>
                <a href="javascript:void(0);" class="comment_digg"
                    onclick="return voteComment(5096460, 'Digg', this.parentElement, false);">
                    支持(0)
                </a>
                <a href="javascript:void(0);" class="comment_burry"
                    onclick="return voteComment(5096460, 'Bury', this.parentElement, false);">
                    反对(0)
                </a>
            </div>
        </div>
      </div>
    </div>
   ''';

    final List<BlogComment> comments = BlogCommentParser.parseBlogCommentList(string);

    expect(comments.length, 2);
    expect(
      comments[0],
      const BlogComment(
        id: 5095633,
        content: "<p>我像是差这3w的人吗？</p>",
        replyToken: "H+5LokWy96mGt7KjYMkRlE5sBFTRzrJd9OzA670EVTgztE2EEtMnaA==",
        author: "some-body",
        homeUrl: "https://home.cnblogs.com/u/797377/",
        diggCount: 2,
        isMe: false,
        buryCount: 0,
        postDate: "2022-08-29 15:30",
      ),
    );
    expect(
      comments[1],
      const BlogComment(
        id: 5096460,
        content: '''<p><a href="#5095633" title="查看所回复的评论" onclick="commentManager.renderComments(0,50,5095633);">@</a>some-body<br>
                    啊</p>''',
        replyToken: "o43e3oVfSqcowFHjawnKoho4ZlZS3Agk+TCS2jvKTih9/+Hf/gl7sg==",
        author: "一二三。",
        homeUrl: "https://home.cnblogs.com/u/2961804/",
        diggCount: 0,
        isMe: false,
        buryCount: 0,
        postDate: "2022-08-31 15:39",
      ),
    );
  });

  test("should return blog comment list and comment by current user", () {
    const String string = '''
  <div>
    <div class="feedbackNoItems">
        <div class="feedbackNoItems"></div>
    </div>
    <div class="feedbackItem">
        <div class="feedbackListSubtitle">
            <div class="feedbackManage">
                <span class="comment_actions">
                    <a href="javascript:void(0);" onclick="return GetCommentBody(5096437)">
                        修改
                    </a>
                    <a href="javascript:void(0);" onclick="return DelComment(5096437, this,'16640741')">
                        删除
                    </a>
                </span>
            </div>
            <a href="#5096437" class="layer">#1楼</a>
            <a name="5096437" id="comment_anchor_5096437"></a>
            <span class="comment_date">2022-08-31 15:07</span>
            <a id="a_comment_author_5096437" href="https://www.cnblogs.com/huhx/" target="_blank">huhx</a>
            <div class="feedbackCon">
                <div id="comment_body_5096437" data-format-type="Markdown" class="blog_comment_body cnblogs-markdown">
                    <p>666</p>
                </div>
                <div class="comment_vote">
                    <span class="comment_error" style="color: red"></span>
                    <a href="javascript:void(0);" class="comment_digg"
                        onclick="return voteComment(5096437, 'Digg', this.parentElement, false);">
                        支持(0)
                    </a>
                    <a href="javascript:void(0);" class="comment_burry"
                        onclick="return voteComment(5096437, 'Bury', this.parentElement, false);">
                        反对(0)
                    </a>
                </div>
                <span id="comment_5096437_avatar" style="display:none">
                    https://pic.cnblogs.com/face/849920/20170517210033.png
                </span>
            </div>
        </div>
      </div>
    </div>
   ''';

    final List<BlogComment> comments = BlogCommentParser.parseBlogCommentList(string);

    expect(comments.length, 1);
    expect(
      comments[0],
      const BlogComment(
        id: 5096437,
        content: "<p>666</p>",
        isMe: true,
        author: "huhx",
        homeUrl: "https://www.cnblogs.com/huhx/",
        diggCount: 0,
        buryCount: 0,
        postDate: "2022-08-31 15:07",
      ),
    );
  });
}
