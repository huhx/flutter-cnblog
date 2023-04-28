import 'package:flutter_cnblog/common/parser/category_parser.dart';
import 'package:flutter_cnblog/model/blog_category.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return grouped category list", () {
    const String string = '''
    <ul class="alt">
      <li>
        <a href="/cate/108701/">软件设计</a>
        <ul>
          <li><a href="/cate/design/">架构设计</a></li>
          <li><a href="/cate//">面向对象</a></li>
        </ul>
      </li>
    </ul>
    <ul class="">
      <li>
        <a href="/cate/108703/">前端开发</a>
        <ul>
          <li><a href="/cate/web/">Html/Css</a></li>
          <li><a href="/cate/javascript/">JavaScript</a></li>
        </ul>
      </li>
    </ul>    
    ''';

    final List<CategoryList> categoryList = CategoryParser.parseCategoryList(string);

    expect(categoryList.length, 2);
    expect(
      categoryList[0],
      const CategoryList(
        group: CategoryInfo(url: "/cate/108701/", label: "软件设计"),
        children: [
          CategoryInfo(url: "/cate/design/", label: "架构设计"),
          CategoryInfo(url: "/cate//", label: "面向对象"),
        ],
      ),
    );
    expect(
      categoryList[1],
      const CategoryList(
        group: CategoryInfo(url: "/cate/108703/", label: "前端开发"),
        children: [
          CategoryInfo(url: "/cate/web/", label: "Html/Css"),
          CategoryInfo(url: "/cate/javascript/", label: "JavaScript"),
        ],
      ),
    );
  });

  test("should return list of blogs", () {
    const String string = '''
    <div id="post_list" class="post-list">
      <article class="post-item" data-post-id="16598124">
        <section class="post-item-body">
          <div class="post-item-text">
            <a class="post-item-title" href="https://www.cnblogs.com/Dongmy/p/16598124.html" target="_blank">关于!this.IsPostBack 使用介绍</a>
            <p class="post-item-summary">
              https://blog.csdn.net/panda_xingfu/article/details/9468695 如果我们需要某些代码只需要执行一次，最好的选择当然是放在 if(!this.IsPostBack){ } 里面. 如果我们不写 if(!this.IsPostBack){ } 那么， ...
            </p>
          </div>
          <footer class="post-item-foot">
            <a href="https://www.cnblogs.com/Dongmy/" class="post-item-author"><span>yinghualeihenmei</span></a>
            <span class="post-meta-item">
                        <span>2022-08-18 11:33</span>
                    </span>
            <a id="digg_control_16598124" class="post-meta-item btn " href="javascript:void(0)" onclick="DiggPost('Dongmy', 16598124, 707872, 1);return false;">
              <svg width="16" height="16" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg">
                <use xlink:href="#icon_digg"></use>
              </svg>
              <span id="digg_count_16598124">0</span>
            </a>
            <a class="post-meta-item btn" href="https://www.cnblogs.com/Dongmy/p/16598124.html#commentform">
              <svg width="16" height="16" xmlns="http://www.w3.org/2000/svg">
                <use xlink:href="#icon_comment"></use>
              </svg>
              <span>0</span>
            </a>
            <a class="post-meta-item btn" href="https://www.cnblogs.com/Dongmy/p/16598124.html">
              <svg width="16" height="16" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg">
                <use xlink:href="#icon_views"></use>
              </svg>
              <span>0</span>
            </a>
            <span id="digg_tip_16598124" class="digg-tip" style="color: red"></span>
          </footer>
        </section>
        <figure>
        </figure>
      </article>
      <article class="post-item" data-post-id="16598114">
        <section class="post-item-body">
          <div class="post-item-text">
            <a class="post-item-title" href="https://www.cnblogs.com/openharmony/p/16598114.html" target="_blank">OpenHarmony轻量设备Hi3861芯片开发板启动流程分析</a>
            <p class="post-item-summary">
              <a href="https://www.cnblogs.com/openharmony/">
                <img src="https://pic.cnblogs.com/face/2824423/20220401120618.png" class="avatar" alt="博主头像">
              </a>
              本文向大家讲述了在没有部分源代码的情况下，如何通过对map文件和asm文件的分析从而得出Hi3861芯片开发板LiteOS-M的启动流程。 ...
            </p>
          </div>
          <footer class="post-item-foot">
            <a href="https://www.cnblogs.com/openharmony/" class="post-item-author"><span>OpenHarmony开发者社区</span></a>
            <span class="post-meta-item">
                        <span>2022-08-18 11:32</span>
                    </span>
            <a id="digg_control_16598114" class="post-meta-item btn " href="javascript:void(0)" onclick="DiggPost('openharmony', 16598114, 745410, 1);return false;">
              <svg width="16" height="16" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg">
                <use xlink:href="#icon_digg"></use>
              </svg>
              <span id="digg_count_16598114">0</span>
            </a>
            <a class="post-meta-item btn" href="https://www.cnblogs.com/openharmony/p/16598114.html#commentform">
              <svg width="16" height="16" xmlns="http://www.w3.org/2000/svg">
                <use xlink:href="#icon_comment"></use>
              </svg>
              <span>0</span>
            </a>
            <a class="post-meta-item btn" href="https://www.cnblogs.com/openharmony/p/16598114.html">
              <svg width="16" height="16" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg">
                <use xlink:href="#icon_views"></use>
              </svg>
              <span>0</span>
            </a>
            <span id="digg_tip_16598114" class="digg-tip" style="color: red"></span>
          </footer>
        </section>
        <figure>
        </figure>
      </article>
    </div>    
    ''';

    final List<BlogResp> blogs = CategoryParser.parseCategory(string);

    expect(blogs.length, 2);
    expect(
      blogs[0],
      BlogResp(
        id: 16598124,
        title: "关于!this.IsPostBack 使用介绍",
        url: "https://www.cnblogs.com/Dongmy/p/16598124.html",
        description:
            "https://blog.csdn.net/panda_xingfu/article/details/9468695 如果我们需要某些代码只需要执行一次，最好的选择当然是放在 if(!this.IsPostBack){ } 里面. 如果我们不写 if(!this.IsPostBack){ } 那么， ...",
        author: "yinghualeihenmei",
        avatar: "",
        postDate: DateTime.parse("2022-08-18 11:33"),
        viewCount: 0,
        commentCount: 0,
        diggCount: 0,
      ),
    );
    expect(
      blogs[1],
      BlogResp(
        id: 16598114,
        title: "OpenHarmony轻量设备Hi3861芯片开发板启动流程分析",
        url: "https://www.cnblogs.com/openharmony/p/16598114.html",
        description: "本文向大家讲述了在没有部分源代码的情况下，如何通过对map文件和asm文件的分析从而得出Hi3861芯片开发板LiteOS-M的启动流程。 ...",
        author: "OpenHarmony开发者社区",
        avatar: "https://pic.cnblogs.com/face/2824423/20220401120618.png",
        postDate: DateTime.parse("2022-08-18 11:32"),
        viewCount: 0,
        commentCount: 0,
        diggCount: 0,
      ),
    );
  });
}
