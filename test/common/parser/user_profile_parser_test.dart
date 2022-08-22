import 'package:flutter_cnblog/common/parser/user_profile_parser.dart';
import 'package:flutter_cnblog/model/user_profile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return profile info of current user", () {
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
        displayName: "huhx",
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

  test("should return profile info of another user", () {
    const String string = '''
    <div id="user_profile_block">
    <table>
        <tbody>
            <tr>
                <td valign="top">
                    <div class="user_avatar">
                        <img src="//pic.cnblogs.com/avatar/simple_avatar.gif" alt="Colorful_coco的头像" class="img_avatar"><br>
                        <table class="user_profile_nav_block">
                            <tbody>
                                <tr>
                                    <td>
                                        <ul class="avatar_nav_block" id="avatar_opt_nav">
                                                <li><a href="https://msg.cnblogs.com/send?recipient=Colorful_coco" id="link_send_msg" class="link_message">发短消息</a></li>
                                            <li><a href="/u/colorful-coco/detail/" class="link_account">个人资料</a></li>
                                            <li><a href="//ing.cnblogs.com/u/colorful-coco/" class="link_mying">闪存主页</a></li>
                                            <li><a href="//q.cnblogs.com/u/colorful-coco/" class="link_question">博问主页</a></li>
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
                            Colorful_coco
                        </h1>
                            <div>
                                <ul id="user_profile" class="user_profile">
                                    <li id="li_remark" style="display:none"><span class="text_gray">备注名称：</span><span id="remarkId"></span></li>
                                    <li><span class="text_gray" title="账户ID">园号：</span><span>1101002</span></li><li><span class="text_gray">园龄：</span><span title="入园时间：2017-02-04">5年6个月</span></li><li><span class="text_gray">入园：</span><span>2017-02-04</span></li><li><span class="text_gray">博客：</span><a id="blog_url" href="https://www.cnblogs.com/colorful-coco/" class="gray" target="_blank">https://www.cnblogs.com/colorful-coco/</a>&nbsp;<span class="text_gray" id="blog_subscription_wrap">[<span id="blog_subscription_text"></span><a id="blog_subscription" class="gray" data-rss="https://www.cnblogs.com/colorful-coco/rss/" href="javascript:void(0);">订阅</a>]</span></li>
                                </ul>
                            </div>
                        <div class="text_gray" style="padding-top: 10px;">
                            <div class="data_count_block" style="padding: 0px 0 15px;">
                                <div class="data_left">
                                    <div class="follow_count"><a id="following_count" href="/u/colorful-coco/followees/">5</a></div>
                                    <a href="/u/colorful-coco/followees/">关注</a>
                                </div>
                                <div class="data_right">
                                    <div class="follow_count"><a id="follower_count" href="/u/colorful-coco/followers/">8</a></div>
                                    <a href="/u/colorful-coco/followers/">粉丝</a>
                                </div>
                                <div class="clear">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="user_intro">
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
    </div>
    ''';

    final UserProfileInfo userProfileInfo = UserProfileParser.parseUserProfile(string);

    expect(
      userProfileInfo,
      const UserProfileInfo(
        name: "colorful-coco",
        displayName: "Colorful_coco",
        avatar: "https://pic.cnblogs.com/avatar/simple_avatar.gif",
        url: "https://www.cnblogs.com/colorful-coco/",
        info: {
          "园号": "1101002",
          "园龄": "5年6个月",
          "入园": "2017-02-04",
          "博客": "https://www.cnblogs.com/colorful-coco/",
        },
        followCounts: 5,
        followerCounts: 8,
      ),
    );
  });

  test("should return user profile recent moments", () {
    const String string = '''
    <ul>
      <li class="feed_item">
        <div class="feed_avatar">
          <a href="/u/huhx"><img src="//pic.cnblogs.com/face/849920/20170517210033.png"></a>
        </div>
        <div class="feed_body" id="feed_content_62edce62440f98faf95676d1">
          <div class="feed_title">
            <a href="/u/huhx/" class="feed_author">huhx</a>
            发表博客： <a href="//www.cnblogs.com/huhx/p/16556548.html" target="_blank" class="feed_link">发布Android库至Maven Central详解</a>
            <a class="recycle" onclick="return deleteFeed('3d5b782a-5399-e511-9fc1-ac853d9f53cc', '62edce62440f98faf95676d1')"
               href="javascript: void(0);" title="删除这个动态">
              <img alt="删除" src="//common.cnblogs.com/images/icon_trash.gif">
            </a>
            <span class="feed_date">2022-08-06 10:13</span>
          </div>
          <div class="feed_desc">
            最近，使用compose编写了一个类QQ的image picker。完成android library的编写，在此记录下发布这个Library到maven central的流程以及碰到的问题。
            maven：https://mvnrepository.com/artifact/io.github.hu
          </div>
        </div>
        <div class="clear"></div>
      </li>
      <li class="feed_item">
        <div class="feed_avatar">
          <a href="/u/huhx"><img src="//pic.cnblogs.com/face/849920/20170517210033.png"></a>
        </div>
        <div class="feed_body" id="feed_content_5f8a5abd4e324e00065036cb">
          <div class="feed_title">
            <a href="/u/huhx/" class="feed_author">huhx</a>
            评论博客： <a href="https://www.cnblogs.com/caobotao/p/5103673.html#4708941" target="_blank"
                         class="feed_link">三种实现Android主界面Tab的方式</a>
            <a class="recycle" onclick="return deleteFeed('3d5b782a-5399-e511-9fc1-ac853d9f53cc', '5f8a5abd4e324e00065036cb')"
               href="javascript: void(0);" title="删除这个动态">
              <img alt="删除" src="//common.cnblogs.com/images/icon_trash.gif">
            </a>
            <span class="feed_date">2020-10-17 10:45</span>
          </div>
          <div class="feed_desc">
            问下，为什么不使用BottomNavigationView呢？有什么考虑的吗
          </div>
        </div>
        <div class="clear"></div>
      </li>
    </ul>
    ''';

    final List<UserProfileMoment> userProfileMoment = UserProfileParser.parseUserProfileMoment(string);

    expect(userProfileMoment.length, 2);
    expect(
      userProfileMoment[0],
      const UserProfileMoment(
        name: "huhx",
        avatar: "https://pic.cnblogs.com/face/849920/20170517210033.png",
        url: "https://www.cnblogs.com/huhx/p/16556548.html",
        action: "发表博客",
        title: "发布Android库至Maven Central详解",
        summary: '''最近，使用compose编写了一个类QQ的image picker。完成android library的编写，在此记录下发布这个Library到maven central的流程以及碰到的问题。
            maven：https://mvnrepository.com/artifact/io.github.hu''',
        postDate: "2022-08-06 10:13",
      ),
    );
    expect(
      userProfileMoment[1],
      const UserProfileMoment(
        name: "huhx",
        avatar: "https://pic.cnblogs.com/face/849920/20170517210033.png",
        url: "https://www.cnblogs.com/caobotao/p/5103673.html#4708941",
        action: "评论博客",
        title: "三种实现Android主界面Tab的方式",
        summary: "问下，为什么不使用BottomNavigationView呢？有什么考虑的吗",
        postDate: "2020-10-17 10:45",
      ),
    );
  });
}
