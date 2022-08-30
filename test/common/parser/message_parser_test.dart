import 'package:flutter_cnblog/common/parser/message_parser.dart';
import 'package:flutter_cnblog/model/message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return inbox message list", () {
    const String string = '''
    <table>
     <tbody>
    <tr id="msg_item_3743325">
        <td width="100px" style="position: absolute;" class="text_overflow_ellipsis">
            <a class="contactLink" href="//home.cnblogs.com/u/2690258/" target="_blank" title="啵啵汽水儿">啵啵汽水儿</a>
        </td>
        <td class="text_overflow_ellipsis">
            <a id="msg_title_3743325" href="/item/3743325" title="51CTO入驻邀请">
                51CTO入驻邀请
            </a>
        </td>
        <td>2022-08-19 10:57</td>
        <td style="width: 40px;">
            <a class="click_del_off" onclick="RemoveMsg('3743325')" title="删除">删除</a>
        </td>
        <td style="width:20px;">
            <input name="chkID" title="选中/取消选中 本短消息" value="3743325" type="checkbox">
        </td>
    </tr>
    <tr id="msg_item_3580924">
        <td width="100px" style="position: absolute;" class="text_overflow_ellipsis">
            系统通知
        </td>
        <td class="text_overflow_ellipsis">
            <a id="msg_title_3580924" href="/item/3580924" title="RE：[博客评论通知]Re:java基础---->Serializable的使用">
                RE：[博客评论通知]Re:java基础----&gt;Serializable的使用
            </a>
        </td>
        <td>2022-02-09 16:30</td>
        <td style="width: 40px;">
            <a class="click_del_off" onclick="RemoveMsg('3580924')" title="删除">删除</a>
        </td>
        <td style="width:20px;">
            <input name="chkID" title="选中/取消选中 本短消息" value="3580924" type="checkbox">
        </td>
    </tr>
</tbody>
</table>
    ''';

    final List<MessageInfo> messages = MessageParser.parseMessageList(string);

    expect(messages.length, 2);
    expect(
      messages[0],
      const MessageInfo(
        id: 3743325,
        author: "啵啵汽水儿",
        title: "51CTO入驻邀请",
        homeUrl: "https://home.cnblogs.com/u/2690258/",
        url: "https://msg.cnblogs.com/item/3743325",
        postDate: "2022-08-19 10:57",
      ),
    );
    expect(
      messages[1],
      const MessageInfo(
        id: 3580924,
        author: "系统通知",
        title: "RE：[博客评论通知]Re:java基础----&gt;Serializable的使用",
        url: "https://msg.cnblogs.com/item/3580924",
        postDate: "2022-02-09 16:30",
      ),
    );
  });

  test("should return outbox message list", () {
    const String string = '''
    <table>
    <tbody>
        <tr id="msg_item_2604297">
            <td>未读</td>
            <td width="100px" style="position: absolute;" class="text_overflow_ellipsis">
                <a class="contactLink" href="//home.cnblogs.com/u/1857741/" target="_blank" title="      dashmm">
                    dashmm
                </a>
            </td>
            <td class="text_overflow_ellipsis">
                <a href="/item/2604297" title="RE：啦啦啦">
                    <b>RE：啦啦啦</b>
                </a>
            </td>
            <td align="center">2019-11-05 09:42</td>
            <td align="center" style="width: 40px;">
                <a class="click_del_off" onclick="RemoveMsg('2604297')" title="删除">删除</a>
            </td>
            <td style="width:20px;" align="left">
                <input name="chkID" title="选中/取消选中 本短消息" value="2604297" type="checkbox">
            </td>
        </tr>
        <tr id="msg_item_2131919">
            <td>已读</td>
            <td width="100px" style="position: absolute;" class="text_overflow_ellipsis">
                <a class="contactLink" href="//home.cnblogs.com/u/1493652/" target="_blank" title="      xia0yu">
                    xia0yu
                </a>
            </td>
            <td class="text_overflow_ellipsis">
                <a href="/item/2131919" title="RE：大佬方便学习一下csii基础基础文章吗，访问需要密码了">
                    RE：大佬方便学习一下csii基础基础文章吗，访问需要密码了
                </a>
            </td>
            <td align="center">2018-09-20 23:59</td>
            <td align="center" style="width: 40px;">
                <a class="click_del_off" onclick="RemoveMsg('2131919')" title="删除">删除</a>
            </td>
            <td style="width:20px;" align="left">
                <input name="chkID" title="选中/取消选中 本短消息" value="2131919" type="checkbox">
            </td>
        </tr>
    </tbody>
    </table>
    ''';

    final List<MessageInfo> messages = MessageParser.parseMessageList(string);

    expect(messages.length, 2);
    expect(
      messages[0],
      const MessageInfo(
          id: 2604297,
          author: "dashmm",
          title: "<b>RE：啦啦啦</b>",
          homeUrl: "https://home.cnblogs.com/u/1857741/",
          url: "https://msg.cnblogs.com/item/2604297",
          postDate: "2019-11-05 09:42",
          status: "未读"),
    );
    expect(
      messages[1],
      const MessageInfo(
          id: 2131919,
          author: "xia0yu",
          title: "RE：大佬方便学习一下csii基础基础文章吗，访问需要密码了",
          homeUrl: "https://home.cnblogs.com/u/1493652/",
          url: "https://msg.cnblogs.com/item/2131919",
          postDate: "2018-09-20 23:59",
          status: "已读"),
    );
  });
}
