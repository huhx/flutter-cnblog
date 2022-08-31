import 'package:flutter_cnblog/common/parser/instant_comment_parser.dart';
import 'package:flutter_cnblog/model/instant_comment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return instant comments list", () {
    const String string = '''
    <div class="feed_ing_comment_block">
        <ul id="comment_block_2320150">
                <li id="comment_2560206">
                    <a href="#" onclick="commentReply(2320150, 2560206, 444532);return false;" title="回应于8-17 08:15"><img src="//common.cnblogs.com/images/quote.gif" alt="" /></a>
                    <a id="comment_author_2560206" href="https://home.cnblogs.com/u/luo630/">快乐的凡人721</a>：<bdo><span class="ing_comment">谁在写✍这条是原始信息</span></bdo>
                    <a class="ing_comment_time" title="回应于8-17 08:15">8-17 08:15</a>
                        <a href="javascript:void(0)" onclick="commentReply(2320150,2560206,444532);return false;" class="ing_reply gray">回复</a>
                </li>
                <li id="comment_2560220">
                    <a href="#" onclick="commentReply(2320150, 2560220, 698385);return false;" title="回应于8-17 08:48"><img src="//common.cnblogs.com/images/quote.gif" alt="" /></a>
                    <a id="comment_author_2560220" href="https://home.cnblogs.com/u/fldev/">小E-减肥16斤</a>：<bdo><span class="ing_comment">666</span></bdo>
                    <a class="ing_comment_time" title="回应于8-17 08:48">8-17 08:48</a>
                        <a href="javascript:void(0)" onclick="commentReply(2320150,2560220,698385);return false;" class="ing_reply gray">回复</a>
                </li>
                <li id="comment_2561014">
                    <a href="#" onclick="commentReply(2320150, 2561014, 849920);return false;" title="回应于8-17 16:20"><img src="//common.cnblogs.com/images/quote.gif" alt="" /></a>
                    <a id="comment_author_2561014" href="https://home.cnblogs.com/u/huhx/">huhx</a>：<bdo><span class="ing_comment"><a href="https://home.cnblogs.com/u/444532/" target="_blank">@快乐的凡人721</a>：功能部分大概完成1/2了</span></bdo>
                        <a class="recycle" onclick="DeleteComment(2561014);return false;" href="javascript:void(0)" title="删除这条评论"><img alt="删除" src="//common.cnblogs.com/images/icon_trash.gif" /></a>
                    <a class="ing_comment_time" title="回应于8-17 16:20">8-17 16:20</a>
                </li>
        </ul>
        <div class="ing_cm_box" id="panel_2320150"></div>
    </div>
    ''';

    final List<InstantComment> instants = InstantCommentParser.parseInstantCommentList(string);
    expect(instants.length, 3);
    expect(
      instants[0],
      const InstantComment(
        id: 2320150,
        replyId: 2560206,
        paneId: 444532,
        toName: "快乐的凡人721",
        toUrl: "https://home.cnblogs.com/u/luo630/",
        content: "谁在写✍这条是原始信息",
        postDate: "8-17 08:15",
      ),
    );
    expect(
      instants[1],
      const InstantComment(
        id: 2320150,
        replyId: 2560220,
        paneId: 698385,
        toName: "小E-减肥16斤",
        toUrl: "https://home.cnblogs.com/u/fldev/",
        content: "666",
        postDate: "8-17 08:48",
      ),
    );
    expect(
      instants[2],
      const InstantComment(
        id: 2320150,
        replyId: 2561014,
        paneId: 849920,
        fromName: "快乐的凡人721",
        fromUrl: "https://home.cnblogs.com/u/444532/",
        toName: "huhx",
        toUrl: "https://home.cnblogs.com/u/huhx/",
        content: "：功能部分大概完成1/2了",
        postDate: "8-17 16:20",
      ),
    );
  });
}
