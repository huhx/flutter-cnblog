import 'package:flutter_cnblog/common/parser/instant_parser.dart';
import 'package:flutter_cnblog/model/instant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return instant list", () {
    const String string = '''
    <ul>
      <li class="entry_b">
        <div class="ing-item">
          <div class="feed_avatar"><a href="//home.cnblogs.com/u/myx3/" target="_blank"><img width="36" height="36" src="https://pic.cnblogs.com/face/2864027/20220502184204.png" alt=""></a></div>
          <div class="feed_body" id="feed_content_2321091">
            <a href="//home.cnblogs.com/u/myx3/" class="ing-author" target="_blank">南城古</a>：
            <bdo><span class="ing_body" id="ing_body_2321091"><a href="/tag/%E6%A0%87%E7%AD%BE/" class="ing_tag">[标签]</a> </span></bdo>
            <a class="ing_time gray" href="/u/myx3/status/2321091/" target="_blank" title="点击进入详细页面">18:38</a>
            <span id="max_ing_id" style="display:none">2321091</span>
            <a href="#" id="a_2321091" onclick="showCommentBox(2321091,2864027);return false;" class="ing_reply gray" title="点击进行回应">回应</a>
            <div class="ing_comments">
              <div class="feed_ing_comment_block">
                <ul id="comment_block_2321091">
                  <li style="display:none">&nbsp;</li>
                </ul>
                <div class="ing_cm_box" id="panel_2321091"></div>
              </div>
            </div>
          </div>
          <div class="clear"></div>
        </div>
      </li>
    
      <li class="entry_b">
        <div class="ing-item">
          <div class="feed_avatar"><a href="//home.cnblogs.com/u/f-bob/" target="_blank"><img width="36" height="36" src="https://pic.cnblogs.com/face/1155215/20171018214843.png" alt=""></a></div>
          <div class="feed_body" id="feed_content_2320939">
            <a href="//home.cnblogs.com/u/f-bob/" class="ing-author" target="_blank">f_Bob</a>：
            <bdo><span class="ing_body" id="ing_body_2320939">这还是技术博客么？</span></bdo>
            <a class="ing_time gray" href="/u/f-bob/status/2320939/" target="_blank" title="点击进入详细页面">16:49</a>
            <a href="#" id="a_2320939" onclick="showCommentBox(2320939,1155215);return false;" class="ing_reply gray" title="点击进行回应">2回应</a>
            <div class="ing_comments">
              <div class="feed_ing_comment_block">
                <ul id="comment_block_2320939">
                  <li id="comment_2561055">
                    <a href="#" onclick="commentReply(2320939, 2561055, 1476811);return false;" title="回应于16:50"><img src="//common.cnblogs.com/images/quote.gif" alt=""></a>
                    <a id="comment_author_2561055" href="//home.cnblogs.com/u/rebo/">Re_Liu</a>：<bdo><span class="ing_comment">这里是闪存地带</span></bdo>
                    <a class="ing_comment_time" title="回应于16:50">16:50</a>
                    <a href="javascript:void(0)" onclick="commentReply(2320939,2561055,1476811);return false;" class="ing_reply gray">回复</a>
                  </li>
                  <li id="comment_2561058">
                    <a href="#" onclick="commentReply(2320939, 2561058, 784108);return false;" title="回应于16:52"><img src="//common.cnblogs.com/images/quote.gif" alt=""></a>
                    <a id="comment_author_2561058" href="//home.cnblogs.com/u/sunshine-wy/">默卿</a>：<bdo><span class="ing_comment">首页是技术，新闻是各种资讯，闪存=摸鱼，各取所需啦</span></bdo>
                    <a class="ing_comment_time" title="回应于16:52">16:52</a>
                    <a href="javascript:void(0)" onclick="commentReply(2320939,2561058,784108);return false;" class="ing_reply gray">回复</a>
                  </li>
                </ul>
                <div class="ing_cm_box" id="panel_2320939"></div>
              </div>
    
            </div>
          </div>
          <div class="clear"></div>
        </div>
      </li>
    </ul>    
    ''';

    final List<InstantInfo> instants = InstantParser.parseInstantList(string);
    expect(instants.length, 2);
    expect(
      instants[0],
      const InstantInfo(
        id: 2321091,
        content: '<span class="ing_body" id="ing_body_2321091"><a href="/tag/%E6%A0%87%E7%AD%BE/" class="ing_tag">[标签]</a> </span>',
        url: "https://ing.cnblogs.com/u/myx3/status/2321091/",
        submitter: "南城古",
        avatar: "https://pic.cnblogs.com/face/2864027/20220502184204.png",
        homeUrl: "https://home.cnblogs.com/u/myx3/",
        postDate: "18:38",
        commentCounts: 0,
        comments: [],
      ),
    );
    expect(
      instants[1],
      const InstantInfo(
        id: 2320939,
        content: '<span class="ing_body" id="ing_body_2320939">这还是技术博客么？</span>',
        url: "https://ing.cnblogs.com/u/f-bob/status/2320939/",
        submitter: "f_Bob",
        avatar: "https://pic.cnblogs.com/face/1155215/20171018214843.png",
        homeUrl: "https://home.cnblogs.com/u/f-bob/",
        postDate: "16:49",
        commentCounts: 2,
        comments: [],
      ),
    );
  });
}
