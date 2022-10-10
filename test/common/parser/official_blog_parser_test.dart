import 'package:flutter_cnblog/common/parser/official_blog_parser.dart';
import 'package:flutter_cnblog/model/official_blog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return official blog list when is review blog", () {
    const String string = '''
    <div class="forFlow">
        <div class="day" role="article" aria-describedby="postlist_description_16685636">
            <div class="dayTitle">
                <a href="https://www.cnblogs.com/cmt/archive/2022/09/12.html">2022年9月12日</a>
            </div>
                <div class="postTitle" role="heading" aria-level="2">
                    <a class="postTitle2 vertical-middle" href="https://www.cnblogs.com/cmt/p/16685636.html">
            <span>
                上周热点回顾（9.5-9.11）
            </span>
        </a>
                </div>
                <div class="postCon">
            <div class="c_b_p_desc" id="postlist_description_16685636">
        摘要：            
        热点随笔： ·&nbsp;没有二十年功力，写不出Thread.sleep(0)这一行“看似无用”的代码！&nbsp;(why技术)·&nbsp;内卷时代下的前端技术-使用JavaScript在浏览器中生成PDF文档&nbsp;(葡萄城技术团队)·&nbsp;终于实现了一门属于自己的编程语言&nbsp;(crossoverJie)·&nbsp;C#/.NET/.NET         <a href="https://www.cnblogs.com/cmt/p/16685636.html" class="c_b_p_desc_readmore">阅读全文</a>
            </div>
                </div>
                <div class="clear"></div>
                <div class="postDesc">
                    posted @ 2022-09-12 10:32
        博客园团队
        <span data-post-id="16685636" class="post-view-count">阅读(442)</span> 
        <span data-post-id="16685636" class="post-comment-count">评论(0)</span> 
        <span data-post-id="16685636" class="post-digg-count">推荐(1)</span> 
        <a href="https://i.cnblogs.com/EditPosts.aspx?postid=16685636" rel="nofollow">
            编辑
        </a>
                </div>
                <div class="clear"></div>
        </div>
    </div>
  ''';

    final List<OfficialBlog> officialBlogs = OfficialBlogParser.parseOfficialBlogList(string);

    expect(officialBlogs.length, 1);
    expect(
        officialBlogs[0],
        const OfficialBlog(
          id: "16685636",
          title: "上周热点回顾（9.5-9.11）",
          url: "https://www.cnblogs.com/cmt/p/16685636.html",
          summary:
              r'''热点随笔： · 没有二十年功力，写不出Thread.sleep(0)这一行“看似无用”的代码！ (why技术)· 内卷时代下的前端技术-使用JavaScript在浏览器中生成PDF文档 (葡萄城技术团队)· 终于实现了一门属于自己的编程语言 (crossoverJie)· C#/.NET/.NET''',
          isReview: true,
          postDate: "2022-09-12 10:32",
          viewCount: 442,
          commentCount: 0,
          diggCount: 1,
        ));
  });

  test("should return official blog list when is not review blog", () {
    const String string = '''
    <div class="forFlow">
        <div class="day" role="article" aria-describedby="postlist_description_16641082">
            <div class="dayTitle">
                <a href="https://www.cnblogs.com/cmt/archive/2022/09/01.html">2022年9月1日</a>
            </div>
            <div class="postTitle" role="heading" aria-level="2">
                <a class="postTitle2 vertical-middle" href="https://www.cnblogs.com/cmt/p/16647139.html">
                    <span>
                        云安全践行者：亚马逊云科技如何打好“安全”牌？
                    </span>
    
                </a>
            </div>
            <div class="postCon">
    
    
                <div class="c_b_p_desc" id="postlist_description_16647139">
                    摘要：
                    云计算发展正迅疾如风，猛烈似火。为业务赋能之下，上“云”已成大势所趋！特别是在疫情持续了将近三年的背景下，云市场需求持续爆发。资本方、企业主、客户、用户等等，云正成为各方最受关注的科技领域。2022年，运营商、独立云厂商、外资云厂商纷纷登场，众多企业“卷”向云端。
                    <a href="https://www.cnblogs.com/cmt/p/16647139.html" class="c_b_p_desc_readmore">阅读全文</a>
                </div>
    
            </div>
            <div class="clear"></div>
            <div class="postDesc">
                posted @ 2022-09-01 16:57
                博客园团队
                <span data-post-id="16647139" class="post-view-count">阅读(3620)</span>
                <span data-post-id="16647139" class="post-comment-count">评论(0)</span>
                <span data-post-id="16647139" class="post-digg-count">推荐(1)</span>
                <a href="https://i.cnblogs.com/EditPosts.aspx?postid=16647139" rel="nofollow">
                    编辑
                </a>
    
            </div>
            <div class="clear"></div>
            <div class="postSeparator"></div>
            <div class="postTitle" role="heading" aria-level="2">
                <a class="postTitle2 vertical-middle" href="https://www.cnblogs.com/cmt/p/16641082.html">
                    <span>
                        HPC+时代，携手亚马逊云科技，共赴数字化升级的星辰大海！
                    </span>
    
                </a>
            </div>
            <div class="postCon">
    
    
                <div class="c_b_p_desc" id="postlist_description_16641082">
                    摘要：
                    传统上，HPC主要应用于大规模计算，如天气预报、石油勘探、药物研发等。这些任务通常借助超级计算机或计算集群运行，需要很多特殊的软硬件来加速节点间通讯并提升性能和可靠性，自成一统的同时也阻碍了拥抱新技术、新平台的步伐。
                    <a href="https://www.cnblogs.com/cmt/p/16641082.html" class="c_b_p_desc_readmore">阅读全文</a>
                </div>
    
            </div>
            <div class="clear"></div>
            <div class="postDesc">
                posted @ 2022-09-01 16:06
                博客园团队
                <span data-post-id="16641082" class="post-view-count">阅读(5597)</span>
                <span data-post-id="16641082" class="post-comment-count">评论(0)</span>
                <span data-post-id="16641082" class="post-digg-count">推荐(0)</span>
                <a href="https://i.cnblogs.com/EditPosts.aspx?postid=16641082" rel="nofollow">
                    编辑
                </a>
    
            </div>
            <div class="clear"></div>
        </div>
    </div>
  ''';

    final List<OfficialBlog> officialBlogs = OfficialBlogParser.parseOfficialBlogList(string);

    expect(officialBlogs.length, 2);
    expect(
      officialBlogs[0],
      const OfficialBlog(
        id: "16647139",
        title: "云安全践行者：亚马逊云科技如何打好“安全”牌？",
        url: "https://www.cnblogs.com/cmt/p/16647139.html",
        summary:
            '''云计算发展正迅疾如风，猛烈似火。为业务赋能之下，上“云”已成大势所趋！特别是在疫情持续了将近三年的背景下，云市场需求持续爆发。资本方、企业主、客户、用户等等，云正成为各方最受关注的科技领域。2022年，运营商、独立云厂商、外资云厂商纷纷登场，众多企业“卷”向云端。''',
        isReview: false,
        postDate: "2022-09-01 16:57",
        viewCount: 3620,
        commentCount: 0,
        diggCount: 1,
      ),
    );
    expect(
      officialBlogs[1],
      const OfficialBlog(
        id: "16641082",
        title: "HPC+时代，携手亚马逊云科技，共赴数字化升级的星辰大海！",
        url: "https://www.cnblogs.com/cmt/p/16641082.html",
        summary: '''传统上，HPC主要应用于大规模计算，如天气预报、石油勘探、药物研发等。这些任务通常借助超级计算机或计算集群运行，需要很多特殊的软硬件来加速节点间通讯并提升性能和可靠性，自成一统的同时也阻碍了拥抱新技术、新平台的步伐。''',
        isReview: false,
        postDate: "2022-09-01 16:06",
        viewCount: 5597,
        commentCount: 0,
        diggCount: 0,
      ),
    );
  });

  test("should return official hot list", () {
    const String string = '''
    <div id="cnblogs_post_body" class="blogpost-body blogpost-body-html">
        <p>热点随笔：</p>
        <p>·&nbsp;
            <a href="https://www.cnblogs.com/thisiswhy/archive/2022/09/05/16657667.html" target="_blank"
                rel="noopener">没有二十年功力，写不出Thread.sleep(0)这一行“看似无用”的代码！</a>&nbsp;(<a
                href="https://www.cnblogs.com/thisiswhy/" target="_blank" rel="noopener">why技术</a>)<br>·&nbsp;
            <a href="https://www.cnblogs.com/powertoolsteam/archive/2022/09/08/16669900.html" target="_blank"
                rel="noopener">内卷时代下的前端技术-使用JavaScript在浏览器中生成PDF文档</a>&nbsp;(<a
                href="https://www.cnblogs.com/powertoolsteam/" target="_blank" rel="noopener">葡萄城技术团队</a>)<br>·&nbsp;
        </p>
        <p>热点新闻：</p>
        <p>·&nbsp;
            <a href="https://news.cnblogs.com/n/727715/" target="_blank" rel="noopener">被赶下班车的外包人</a><br>·&nbsp;
            <a href="https://news.cnblogs.com/n/727978/" target="_blank" rel="noopener">微软全力拥抱 Java ！</a><br>·&nbsp;
        </p>
    </div>
  ''';

    final List<OfficialHot> officialHotList = OfficialBlogParser.parseOfficialHotList(string);

    expect(officialHotList.length, 4);
    expect(
      officialHotList[0],
      const OfficialHot(
        id: "16657667",
        title: "没有二十年功力，写不出Thread.sleep(0)这一行“看似无用”的代码！",
        url: "https://www.cnblogs.com/thisiswhy/archive/2022/09/05/16657667.html",
        name: "why技术",
        homeUrl: "https://www.cnblogs.com/thisiswhy/",
        hotType: OfficialHotType.blog,
      ),
    );
    expect(
      officialHotList[1],
      const OfficialHot(
        id: "16669900",
        title: "内卷时代下的前端技术-使用JavaScript在浏览器中生成PDF文档",
        url: "https://www.cnblogs.com/powertoolsteam/archive/2022/09/08/16669900.html",
        name: "葡萄城技术团队",
        homeUrl: "https://www.cnblogs.com/powertoolsteam/",
        hotType: OfficialHotType.blog,
      ),
    );
    expect(
      officialHotList[2],
      const OfficialHot(
        id: "727715",
        title: "被赶下班车的外包人",
        url: "https://news.cnblogs.com/n/727715/",
        name: "itwriter",
        hotType: OfficialHotType.news,
      ),
    );
    expect(
      officialHotList[3],
      const OfficialHot(
        id: "727978",
        title: "微软全力拥抱 Java ！",
        url: "https://news.cnblogs.com/n/727978/",
        name: "itwriter",
        hotType: OfficialHotType.news,
      ),
    );
  });
}
