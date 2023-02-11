import 'package:flutter_cnblog/common/parser/news_parser.dart';
import 'package:flutter_cnblog/model/news.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return news list", () {
    const String string = '''
    <div class="news_block" id="entry_726729">
      <div class="action">
        <div class="diggit" onclick="VoteNews(726729,'agree')">
          <span id="digg_num_726729" class="diggnum">0</span>
        </div>
        <div class="clear"></div>
        <div id="digg_tip_726729" class="digg-tip"></div>
      </div>
      <!--end: action -->
      <div class="content">
        <h2 class="news_entry">
          <a href="/n/726729/" target="_blank">外媒：美国NASA登月重型火箭将于8月底首次试飞</a>
        </h2>
        <div class="entry_summary" style="display: block;">
          <a href="/n/topic_345.htm"><img src="https://img2018.cnblogs.com/news_topic/20190528103402943-154105954.png" class="topic_img" alt=""></a>
          中新网 8 月 17 日电&nbsp;据路透社报道，美国国家航空航天局(NASA)的“太空发射系统”(Space Launch System)重型火箭于当地时间 8 月 16 日晚间被运往发射台，并将于 8 月 29 日首次试飞。 资料图/视觉中国 报道称，该任务将开始为期 42 天的月球往返之旅。这是“阿尔
        </div>
        <div class="entry_footer">
          <a href="//home.cnblogs.com/u/itwriter/" class="gray" target="_blank">
            itwriter
          </a>投递&nbsp;
          <span class="comment">
                                <a href="/n/726729#comment" class="gray" target="_blank">评论(0)</a>
                            </span><span class="view">35 人浏览</span>
          <span class="tag"> <a href="/n/tag/NASA/" class="gray">NASA</a> </span>
          发布于 <span class="gray">2022-08-18 12:38</span>
        </div>
        <!--end: entry_footer -->
      </div>
      <!--end: content -->
      <div class="clear">
      </div>
    </div>     
    ''';

    final List<NewsInfo> newsList = NewsParser.parseNewsList(string);

    expect(newsList.length, 1);
    expect(
      newsList[0],
      NewsInfo(
        id: 726729,
        title: "外媒：美国NASA登月重型火箭将于8月底首次试飞",
        url: "/n/726729/",
        submitter: "itwriter",
        summary:
            '中新网 8 月 17 日电 据路透社报道，美国国家航空航天局(NASA)的“太空发射系统”(Space Launch System)重型火箭于当地时间 8 月 16 日晚间被运往发射台，并将于 8 月 29 日首次试飞。 资料图/视觉中国 报道称，该任务将开始为期 42 天的月球往返之旅。这是“阿尔',
        cover: "https://img2018.cnblogs.com/news_topic/20190528103402943-154105954.png",
        homeUrl: "https://home.cnblogs.com/u/itwriter/",
        commentCount: 0,
        diggCount: 0,
        viewCount: 35,
        postDate: DateTime.parse("2022-08-18 12:38"),
      ),
    );
  });
}
