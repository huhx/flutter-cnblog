import 'package:flutter_cnblog/common/parser/candidate_parser.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return candidate blog list", () {
    const String string = '''
    <div id="post_list" class="post_list">
      <article class="post-item" data-post-id="16596473">
        <section class="post-item-body">
          <div class="post-item-text">
            <a class="post-item-title" href="https://www.cnblogs.com/yangwilly/p/16596473.html" target="_blank">【StoneDB Class】入门第三课：StoneDB的编译安装</a>
            <p class="post-item-summary">
              <a href="https://www.cnblogs.com/yangwilly/">
                <img src="https://pic.cnblogs.com/face/2949896/20220809132842.png" class="avatar" alt="博主头像">
              </a>
              本课程主要介绍 StoneDB-5.6 在 Ubuntu 20.04 LTS 下的手动编译，在 CentOS 和 RedHat 的编译详见官方文档。 如果想快速部署，详见官方文档 https://stonedb.io/zh/docs/getting-started/quick-deployment  ...
            </p>
          </div>
          <footer class="post-item-foot">
            <a href="https://www.cnblogs.com/yangwilly/" class="post-item-author"><span>来来士</span></a>
            <span class="post-meta-item">
                        <span>2022-08-17 19:09</span>
                    </span>
            <a id="digg_control_16596473" class="post-meta-item btn " href="javascript:void(0)" onclick="DiggPost('yangwilly', 16596473, 763115, 1);return false;">
              <svg width="16" height="16" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg">
                <use xlink:href="#icon_digg"></use>
              </svg>
              <span id="digg_count_16596473">0</span>
            </a>
            <a class="post-meta-item btn" href="https://www.cnblogs.com/yangwilly/p/16596473.html#commentform">
              <svg width="16" height="16" xmlns="http://www.w3.org/2000/svg">
                <use xlink:href="#icon_comment"></use>
              </svg>
              <span>0</span>
            </a>
            <a class="post-meta-item btn" href="https://www.cnblogs.com/yangwilly/p/16596473.html">
              <svg width="16" height="16" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg">
                <use xlink:href="#icon_views"></use>
              </svg>
              <span>10</span>
            </a>
            <span id="digg_tip_16596473" class="digg-tip" style="color: red"></span>
          </footer>
        </section>
        <figure>
        </figure>
      </article>
    </div>
 
   ''';

    final List<BlogResp> blogs = CandidateParser.parseCandidateList(string);

    expect(blogs.length, 1);
    expect(
      blogs[0],
      BlogResp(
        id: 16596473,
        title: "【StoneDB Class】入门第三课：StoneDB的编译安装",
        url: "https://www.cnblogs.com/yangwilly/p/16596473.html",
        description:
            "本课程主要介绍 StoneDB-5.6 在 Ubuntu 20.04 LTS 下的手动编译，在 CentOS 和 RedHat 的编译详见官方文档。 如果想快速部署，详见官方文档 https://stonedb.io/zh/docs/getting-started/quick-deployment  ...",
        author: "来来士",
        blogApp: "yangwilly",
        avatar: "https://pic.cnblogs.com/face/2949896/20220809132842.png",
        postDate: DateTime.parse("2022-08-17 19:09"),
        viewCount: 10,
        commentCount: 0,
        diggCount: 0,
      ),
    );
  });
}
