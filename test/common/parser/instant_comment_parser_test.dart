import 'package:flutter_cnblog/common/parser/instant_comment_parser.dart';
import 'package:flutter_cnblog/model/instant_comment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return instant comments list", () {
    const String string = '''
    <div class="comment_list_block">
      <ul id="comment_block_2345451">
        <li id="comment_2581796">
          <div>
            <a target="_blank" href="//home.cnblogs.com/u/YueJinSanQian/"><img src="https://pic.cnblogs.com/face/1320658/20180208115726.png" class="ing_comment_face" alt=""></a>
            <a target="_blank" id="comment_author_2581796" href="//home.cnblogs.com/u/YueJinSanQian/">阅尽三千</a>:
            <bdo>那是花蜜 不是蜂蜜</bdo>
            <span class="text_green" title="2022-09-19 17:51:58">&nbsp;&nbsp;2022-09-19 17:51:58&nbsp;&nbsp;</span>
            <a href="#" onclick="commentReply(2345451,2581796,1320658);return false;" class="gray3">回复</a>&nbsp;
            <span></span>
          </div>
        </li>
        <li id="comment_2581797">
          <div>
            <a target="_blank" href="//home.cnblogs.com/u/lilith-lt/"><img src="https://pic.cnblogs.com/face/1846416/20211227204842.png" class="ing_comment_face" alt=""></a>
            <a target="_blank" id="comment_author_2581797" href="//home.cnblogs.com/u/lilith-lt/">乂千</a>:
            <bdo><a href="https://home.cnblogs.com/u/1320658/" target="_blank">@阅尽三千</a>：不一样吗？</bdo>
            <span class="text_green" title="2022-09-19 17:55:00">&nbsp;&nbsp;2022-09-19 17:55:00&nbsp;&nbsp;</span>
            <a href="#" onclick="commentReply(2345451,2581797,1846416);return false;" class="gray3">回复</a>&nbsp;
            <span></span>
          </div>
        </li>
        <li id="comment_2581799">
          <div>
            <a target="_blank" href="//home.cnblogs.com/u/ls-myblogs/"><img src="https://pic.cnblogs.com/face/1238438/20220719184435.png" class="ing_comment_face" alt=""></a>
            <a target="_blank" id="comment_author_2581799" href="//home.cnblogs.com/u/ls-myblogs/">大长老</a>:
            <bdo><a href="https://home.cnblogs.com/u/1846416/" target="_blank">@乂千</a>：当然不一样，蜜蜂得将花蜜带到蜂巢里酿制才能变成蜂蜜</bdo>
            <span class="text_green" title="2022-09-19 18:00:29">&nbsp;&nbsp;2022-09-19 18:00:29&nbsp;&nbsp;</span>
            <a href="#" onclick="commentReply(2345451,2581799,1238438);return false;" class="gray3">回复</a>&nbsp;
            <span></span>
          </div>
        </li>
      </ul>
    </div>
    ''';

    final List<InstantComment> instants = InstantCommentParser.parseInstantCommentList(string);
    expect(instants.length, 3);
    expect(
      instants[0],
      const InstantComment(
        id: 2345451,
        replyId: 2581796,
        toName: "阅尽三千",
        toUrl: "https://home.cnblogs.com/u/YueJinSanQian/",
        avatar: "https://pic.cnblogs.com/face/1320658/20180208115726.png",
        content: "那是花蜜 不是蜂蜜",
        postDate: "2022-09-19 17:51:58",
      ),
    );
    expect(
      instants[1],
      const InstantComment(
        id: 2345451,
        replyId: 2581797,
        fromName: "阅尽三千",
        fromUrl: "https://home.cnblogs.com/u/1320658/",
        toName: "乂千",
        toUrl: "https://home.cnblogs.com/u/lilith-lt/",
        avatar: "https://pic.cnblogs.com/face/1846416/20211227204842.png",
        content: '<a href="https://home.cnblogs.com/u/1320658/" target="_blank">@阅尽三千</a>：不一样吗？',
        postDate: "2022-09-19 17:55:00",
      ),
    );
    expect(
      instants[2],
      const InstantComment(
        id: 2345451,
        replyId: 2581799,
        fromName: "乂千",
        fromUrl: "https://home.cnblogs.com/u/1846416/",
        toName: "大长老",
        toUrl: "https://home.cnblogs.com/u/ls-myblogs/",
        avatar: "https://pic.cnblogs.com/face/1238438/20220719184435.png",
        content: '<a href="https://home.cnblogs.com/u/1846416/" target="_blank">@乂千</a>：当然不一样，蜜蜂得将花蜜带到蜂巢里酿制才能变成蜂蜜',
        postDate: "2022-09-19 18:00:29",
      ),
    );
  });


  test("should return my instant comments list", () {
    const String string = '''
    <div class="comment_list_block">
      <ul id="comment_block_2330496">
        <li id="comment_2570697">
          <div>
            <a target="_blank" href="//home.cnblogs.com/u/huhongxiang/"><img src="https://pic.cnblogs.com/face/917292/20170524184644.png" class="ing_comment_face" alt=""></a>
            <a target="_blank" id="comment_author_2570697" href="//home.cnblogs.com/u/huhongxiang/">gohuhx</a>:
            <bdo><a href="https://home.cnblogs.com/u/849920/" target="_blank">@huhx</a> hello</bdo>
            <span class="text_green" title="2022-08-31 22:44:53">&nbsp;&nbsp;2022-08-31 22:44:53&nbsp;&nbsp;</span>
            <a href="#" onclick="commentReply(2330496,2570697,917292);return false;" class="gray3">回复</a>&nbsp;
            <span><a class="recycle" onclick="DeleteComment(2570697)" href="###" title="删除这条评论"><img alt="删除" src="//common.cnblogs.com/images/icon_trash.gif"></a></span>
          </div>
        </li>
        <li id="comment_2572673">
          <div>
            <a target="_blank" href="//home.cnblogs.com/u/huhx/"><img src="https://pic.cnblogs.com/face/849920/20170517210033.png" class="ing_comment_face" alt=""></a>
            <a target="_blank" id="comment_author_2572673" href="//home.cnblogs.com/u/huhx/">huhx</a>:
            <bdo>test it</bdo>
            <span class="text_green" title="2022-09-02 14:13:15">&nbsp;&nbsp;2022-09-02 14:13:15&nbsp;&nbsp;</span>
            &nbsp;
            <span><a class="recycle" onclick="DeleteComment(2572673)" href="###" title="删除这条评论"><img alt="删除" src="//common.cnblogs.com/images/icon_trash.gif"></a></span>
          </div>
        </li>
        <li id="comment_2581831">
          <div>
            <a target="_blank" href="//home.cnblogs.com/u/huhx/"><img src="https://pic.cnblogs.com/face/849920/20170517210033.png" class="ing_comment_face" alt=""></a>
            <a target="_blank" id="comment_author_2581831" href="//home.cnblogs.com/u/huhx/">huhx</a>:
            <bdo><a href="https://home.cnblogs.com/u/917292/" target="_blank">@gohuhx</a>：hello</bdo>
            <span class="text_green" title="2022-09-19 19:53:09">&nbsp;&nbsp;2022-09-19 19:53:09&nbsp;&nbsp;</span>
            &nbsp;
            <span><a class="recycle" onclick="DeleteComment(2581831)" href="###" title="删除这条评论"><img alt="删除" src="//common.cnblogs.com/images/icon_trash.gif"></a></span>
          </div>
        </li>
      </ul>
    </div>
    ''';

    final List<InstantComment> instants = InstantCommentParser.parseInstantCommentList(string);
    expect(instants.length, 3);
    expect(
      instants[0],
      const InstantComment(
        id: 2330496,
        replyId: 2570697,
        fromName: "huhx",
        fromUrl: "https://home.cnblogs.com/u/849920/",
        toName: "gohuhx",
        toUrl: "https://home.cnblogs.com/u/huhongxiang/",
        avatar: "https://pic.cnblogs.com/face/917292/20170524184644.png",
        content: '<a href="https://home.cnblogs.com/u/849920/" target="_blank">@huhx</a> hello',
        postDate: "2022-08-31 22:44:53",
      ),
    );
    expect(
      instants[1],
      const InstantComment(
        id: 2330496,
        replyId: 2572673,
        toName: "huhx",
        toUrl: "https://home.cnblogs.com/u/huhx/",
        avatar: "https://pic.cnblogs.com/face/849920/20170517210033.png",
        content: 'test it',
        postDate: "2022-09-02 14:13:15",
      ),
    );
    expect(
      instants[2],
      const InstantComment(
        id: 2330496,
        replyId: 2581831,
        fromName: "gohuhx",
        fromUrl: "https://home.cnblogs.com/u/917292/",
        toName: "huhx",
        toUrl: "https://home.cnblogs.com/u/huhx/",
        avatar: "https://pic.cnblogs.com/face/849920/20170517210033.png",
        content: '<a href="https://home.cnblogs.com/u/917292/" target="_blank">@gohuhx</a>：hello',
        postDate: "2022-09-19 19:53:09",
      ),
    );
  });


}
