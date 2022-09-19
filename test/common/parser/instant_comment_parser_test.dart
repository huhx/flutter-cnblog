import 'package:flutter_cnblog/common/parser/instant_comment_parser.dart';
import 'package:flutter_cnblog/model/instant_comment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return instant comments list", () {
    const String string = '''
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
    ''';

    final List<InstantComment> instants = InstantCommentParser.parseInstantCommentList(string);
    expect(instants.length, 3);
    expect(
      instants[0],
      const InstantComment(
        id: 2345451,
        replyId: 2581796,
        paneId: 1320658,
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
        paneId: 1846416,
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
        paneId: 1238438,
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
}
