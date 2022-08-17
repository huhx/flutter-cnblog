import 'package:flutter_cnblog/common/parser/bookmark_parser.dart';
import 'package:flutter_cnblog/model/bookmark.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return bookmark list", () {
    const String string = '''
    <div class="list_block" id="link_7094389">
        <h2>
            <a rel="nofollow" href="https://www.cnblogs.com/zhangziqiu/archive/2009/04/30/jQuery-Learn-1.html" target="_blank">从零开始学习jQuery (一) 开天辟地入门篇 - 子秋的博客 - 博客园</a>
            <i class="iconfont icon-fold-up middle" title="折叠"></i>
        </h2>
        <div class="link_content">
            
            <span class="url">
                <a rel="nofollow" href="https://www.cnblogs.com/zhangziqiu/archive/2009/04/30/jQuery-Learn-1.html" target="_blank" title="从零开始学习jQuery (一) 开天辟地入门篇 - 子秋的博客 - 博客园" class="url">https://www.cnblogs.com/zhangziqiu/archive/2009/04/30/jQuery-Learn-1.html </a>
            </span>
        </div>
        <div class="link_memo">
            收藏于&nbsp;<span class="date" title="08/16/2022 18:02:18">23小时前</span>
            &nbsp;&nbsp;<i class="iconfont icon-shoucang"></i><span class="wz_item_count">14</span>人收藏
            
            <span>
                <a href="###" class="mini wz_edit">修改</a>
            </span>
            <span>
                <a href="###" id="wzdel_7094389" class="mini wz_del">删除</a>
            </span>
        </div>
    </div>
  ''';

    final List<BookmarkInfo> bookmarks = BookmarkParser.parseBookmarkList(string);

    expect(bookmarks.length, 1);
    expect(
      bookmarks[0],
      BookmarkInfo(
        id: 7094389,
        title: "从零开始学习jQuery (一) 开天辟地入门篇 - 子秋的博客 - 博客园",
        url: "https://www.cnblogs.com/zhangziqiu/archive/2009/04/30/jQuery-Learn-1.html",
        starCounts: 14,
        postDate: DateTime.parse("2022-08-16 18:02:18"),
      ),
    );
  });
}
