import 'package:flutter_cnblog/common/parser/user_profile_parser.dart';
import 'package:flutter_cnblog/model/user_profile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return user profile info", () {
    const String string = '''
    <div id="user_profile_block">
        <table>
            <tbody>
                <tr>
                    <td valign="top">
                        <div class="user_avatar">
                            <img src="//pic.cnblogs.com/avatar/849920/20170517210033.png" alt="huhx的头像" class="img_avatar"><br>
                            <table class="user_profile_nav_block">
                                <tbody>
                                    <tr>
                                        <td>
                                            <ul class="avatar_nav_block" id="avatar_opt_nav">
                                                    <li><a href="/set/avatar/" class="link_modify_info">修改头像</a></li>
                                                <li><a href="/u/huhx/detail/" class="link_account">个人资料</a></li>
                                                <li><a href="//ing.cnblogs.com/u/huhx/" class="link_mying">闪存主页</a></li>
                                                <li><a href="//q.cnblogs.com/u/huhx/" class="link_question">博问主页</a></li>
                                            </ul>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </td>
                    <td valign="top">
                        <div>
                            <h1 class="display_name">
                                huhx
                            </h1>
                                <div>
                                    <ul id="user_profile" class="user_profile">
                                        <li id="li_remark" style="display:none"><span class="text_gray">备注名称：</span><span id="remarkId"></span></li>
                                        <li><span class="text_gray">家乡：</span>湖北省-黄冈市</li>
                                        <li><span class="text_gray">现居住地：</span>湖北省-武汉市</li>
                                        <li><span class="text_gray">职位：</span>java软件开发</li>
                                        <li><span class="text_gray">工作状况：</span>已工作</li>
                                        <li><span class="text_gray">感兴趣的技术：</span>android，java、 python、 js、 go</li>
                                        <li><span class="text_gray" title="账户ID">园号：</span><span>849920</span></li>
                                        <li><span class="text_gray">园龄：</span><span title="入园时间：2015-12-03">6年8个月</span></li>
                                        <li><span class="text_gray">入园：</span><span>2015-12-03</span></li>
                                        <li><span class="text_gray">博客：</span><a id="blog_url" href="https://www.cnblogs.com/huhx/" class="gray" target="_blank">https://www.cnblogs.com/huhx/</a></li>
                                    </ul>
                                </div>
                            <div class="text_gray" style="padding-top: 10px;">
                                <div class="data_count_block" style="padding: 0px 0 15px;">
                                    <div class="data_left">
                                        <div class="follow_count"><a id="following_count" href="/u/huhx/followees/">3</a></div>
                                        <a href="/u/huhx/followees/">关注</a>
                                    </div>
                                    <div class="data_right">
                                        <div class="follow_count"><a id="follower_count" href="/u/huhx/followers/">185</a></div>
                                        <a href="/u/huhx/followers/">粉丝</a>
                                    </div>
                                    <div class="clear">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
        <br>
    </div>
    ''';

    final UserProfileInfo userProfileInfo = UserProfileParser.parseUserProfile(string);

    expect(
      userProfileInfo,
      const UserProfileInfo(
        name: "huhx",
        avatar: "https://pic.cnblogs.com/avatar/849920/20170517210033.png",
        url: "https://www.cnblogs.com/huhx/",
        info: {
          "家乡": "湖北省-黄冈市",
          "现居住地": "湖北省-武汉市",
          "职位": "java软件开发",
          "工作状况": "已工作",
          "感兴趣的技术": "android，java、 python、 js、 go",
          "园号": "849920",
          "园龄": "6年8个月",
          "入园": "2015-12-03",
          "博客": "https://www.cnblogs.com/huhx/",
        },
        followCounts: 3,
        followerCounts: 185,
      ),
    );
  });
}
