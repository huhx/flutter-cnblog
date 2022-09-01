import 'package:flutter_cnblog/common/parser/blog_post_parser.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return blog data info", () {
    const String string = '''
    <div id="green_channel">
            <a href="javascript:void(0);" id="green_channel_digg">已推荐</a>
            <a id="green_channel_follow" onclick="follow('45ddeb60-bb72-4277-25a8-08d9a5cb8bcb');" href="javascript:void(0);">关注我</a>
        <a id="green_channel_favorite" onclick="AddToWz(cb_entryId);return false;" href="javascript:void(0);">收藏该文</a>
        <a id="green_channel_weibo" href="javascript:void(0);" title="分享至新浪微博" onclick="ShareToTsina()"><img src="https://common.cnblogs.com/images/icon_weibo_24.png" alt="" /></a>
        <a id="green_channel_wechat" href="javascript:void(0);" title="分享至微信" onclick="shareOnWechat()"><img src="https://common.cnblogs.com/images/wechat.png" alt="" /></a>
    </div>
    <div id="author_profile">
        <div id="author_profile_info" class="author_profile_info">
                <a href="https://home.cnblogs.com/u/mantou0/" target="_blank"><img src="https://pic.cnblogs.com/face/2633401/20211114120743.png" class="author_avatar" alt="" /></a>
            <div id="author_profile_detail" class="author_profile_info">
                <a href="https://home.cnblogs.com/u/mantou0/">馒头/</a><br />
                <a href="https://home.cnblogs.com/u/mantou0/followers/">粉丝 - <span class="follower-count">8</span></a>
                <a href="https://home.cnblogs.com/u/mantou0/followees/">关注 - <span class="following-count">4</span></a><br />
            </div>
        </div>
        <div class="clear"></div>
        <div id="author_profile_honor"></div>
        <div id="author_profile_follow" class="follow-tip">
                    <a href="javascript:void(0);" onclick="follow('45ddeb60-bb72-4277-25a8-08d9a5cb8bcb');return false;">+加关注</a>
        </div>
    </div>
    <div id="div_digg">
        <div class="diggit" onclick="votePost(16645348,'Digg')">
            <span class="diggnum" id="digg_count">2</span>
        </div>
        <div class="buryit" onclick="votePost(16645348,'Bury')">
            <span class="burynum" id="bury_count">0</span>
        </div>
        <div class="clear"></div>
        <div class="diggword" id="digg_tips">
                您已推荐过，<a href="javascript:void(0);" onclick="votePost(16645348, 'Digg', true);return false;" class="digg_gray">取消</a>
        </div>
    </div>
  ''';

    final BlogPostInfo blogPostInfo = BlogPostInfoParser.parseBlogPostInfo(string);

    expect(
      blogPostInfo,
      const BlogPostInfo(
        followingCount: 4,
        followerCount: 8,
        diggCount: 2,
        buryCount: 0,
        isDigg: true,
        isBury: false,
      ),
    );
  });
}
