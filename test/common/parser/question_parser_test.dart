import 'package:flutter_cnblog/common/parser/question_parser.dart';
import 'package:flutter_cnblog/model/question.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return question list", () {
    const String string = '''
    <div class="left_sidebar">
      <div class="one_entity">
        <div class="answercount">
          <div class="diggit">
            <div class="diggnum unanswered">0</div>
            <div class="diggword">回答数</div>
          </div>
          <div class="clear">
          </div>
        </div>
        <div id="news_item_141530" class="news_item">
          <h2 class="news_entry">
            <span class="gold">5</span><img alt="" src="//common.cnblogs.com/images/icons/yuandou20170322.png" class="coin-icon">
    
            <a target="_blank" href="/q/141530/">kafka的偏移量索引文件，时间戳索引文件的清理</a>
        
          </h2>
          <div class="news_summary">
            请教给问题，我们产线c盘满了，原因是因为kafka的偏移量索引文件，时间戳索引文件![] 没有清除（或者变成0kb），只是xxxx.log数据文件变成了0kb（配置的7天自动清除），想问下有没有配置让        </div>
          <div class="news_footer">
            <div class="question-tag-div">
            </div>
            <div class="news_footer_user">
              <a href="/u/menglin2010/" class="author">
                <img alt="David.Meng的主页" src="//pic.cnblogs.com/face/42037/20210729153551.png">
              </a>
              <a href="/u/menglin2010/" class="news_contributor">
                David.Meng
              </a>
              <br>
              <a class="question-answer-count">
                回答(0)
              </a>
              浏览(4)
              <span title="2022-08-18 10:13" class="date">4小时前</span>
            </div>
          </div>
          <div class="clear">
          </div>
        </div>
      </div>
      
       <div class="one_entity">
          <div class="answercount">
              <div class="diggit">
                  <div class="diggnum answered">1</div>
                  <div class="diggword">回答数</div>
              </div>
              <div class="clear">
              </div>
          </div>
          <div id="news_item_141524" class="news_item">
              <h2 class="news_entry">
      
                      <a target="_blank" href="/q/141524/">对WinForm控件取值，牵扯跨线程的问题吗？</a>
      
              </h2>
              <div class="news_summary">
      比如在非UI线程中取控件值： bool check = checkBox2.Checked; 这样的语句对吗？ 还是说必须： bool check =true; checkBox2.Invoke(ne        </div>
              <div class="news_footer">
                  <div class="question-tag-div">
                  </div>
                  <div class="news_footer_user">
                      <a href="/u/tider1999/" class="author">
                          <img alt="泰德的主页" src="//pic.cnblogs.com/default-avatar.png">
                      </a>
                      <a href="/u/tider1999/" class="news_contributor">
                          泰德
                      </a>
                      <br>
                      <a class="question-answer-count">
                          回答(1)
                      </a>
                      浏览(44)
                          <span title="2022-08-17 01:08" class="date">1天前</span>
                  </div>
              </div>
              <div class="clear">
              </div>
          </div>
      </div>
    </div>
    ''';

    final List<QuestionInfo> questions = QuestionParser.parseQuestionList(string);

    expect(questions.length, 2);
    expect(
      questions[0],
      QuestionInfo(
        id: 141530,
        title: "kafka的偏移量索引文件，时间戳索引文件的清理",
        url: "/q/141530/",
        submitter: "David.Meng",
        summary: "请教给问题，我们产线c盘满了，原因是因为kafka的偏移量索引文件，时间戳索引文件![] 没有清除（或者变成0kb），只是xxxx.log数据文件变成了0kb（配置的7天自动清除），想问下有没有配置让",
        avatar: "https://pic.cnblogs.com/face/42037/20210729153551.png",
        homeUrl: "/u/menglin2010/",
        answerCount: 0,
        goldCount: 5,
        viewCount: 4,
        postDate: DateTime.parse("2022-08-18 10:13"),
        answeredDate: null,
      ),
    );
    expect(
      questions[1],
      QuestionInfo(
        id: 141524,
        title: "对WinForm控件取值，牵扯跨线程的问题吗？",
        url: "/q/141524/",
        submitter: "泰德",
        summary: "比如在非UI线程中取控件值： bool check = checkBox2.Checked; 这样的语句对吗？ 还是说必须： bool check =true; checkBox2.Invoke(ne",
        avatar: "https://pic.cnblogs.com/default-avatar.png",
        homeUrl: "/u/tider1999/",
        answerCount: 1,
        goldCount: 0,
        viewCount: 44,
        postDate: DateTime.parse("2022-08-17 01:08"),
        answeredDate: null,
      ),
    );
  });

  test("should return resolved question list", () {
    const String string = '''
    <div class="left_sidebar">
      <div class="one_entity">
        <div class="answercount">
          <div class="diggit">
            <div class="diggnum answered">1</div>
            <div class="diggword">回答数</div>
          </div>
          <div class="clear">
          </div>
        </div>
        <div id="news_item_141532" class="news_item">
          <h2 class="news_entry">
            <span class="gold">20</span><img alt="" src="//common.cnblogs.com/images/icons/yuandou20170322.png" class="coin-icon">
      
            <a target="_blank" href="/q/141532/">博客园美化bug如何解决？</a>
      
          </h2>
          <div class="news_summary">
            这是我的博客：https://www.cnblogs.com/Jason142/ 请问如何解决博客内容右移的bug
          </div>
          <div class="news_footer">
            <div class="question-tag-div">
              <a class="detail_tag" href="/tag/%E5%8D%9A%E5%AE%A2%E7%BE%8E%E5%8C%96">博客美化</a>
            </div>
            <div class="news_footer_user">
              <a href="/u/Jason142/" class="author">
                <img alt="Jason142的主页" src="//pic.cnblogs.com/face/2759959/20220411145127.png">
              </a>
              <a href="/u/Jason142/" class="news_contributor">
                Jason142
              </a>
              <br>
              <a class="question-answer-count">
                回答(1)
              </a>
              浏览(10)
              <span title="解决于 2022-08-18 10:44 " class="date">解决于4小时前</span>
            </div>
          </div>
          <div class="clear">
          </div>
        </div>
      </div>     
    </div>
    ''';

    final List<QuestionInfo> questions = QuestionParser.parseQuestionList(string);

    expect(questions.length, 1);
    expect(
      questions[0],
      QuestionInfo(
        id: 141532,
        title: "博客园美化bug如何解决？",
        url: "/q/141532/",
        submitter: "Jason142",
        summary: "这是我的博客：https://www.cnblogs.com/Jason142/ 请问如何解决博客内容右移的bug",
        avatar: "https://pic.cnblogs.com/face/2759959/20220411145127.png",
        homeUrl: "/u/Jason142/",
        answerCount: 1,
        goldCount: 20,
        viewCount: 10,
        postDate: null,
        answeredDate: DateTime.parse("2022-08-18 10:44"),
      ),
    );
  });
}
