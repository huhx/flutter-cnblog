import 'package:flutter_cnblog/common/parser/user_blog_parser.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return user profile blog pinned list", () {
    const String string = '''
    <div class="forFlow">
      <div class="day" role="article" aria-describedby="postlist_description_5267805">
        <div class="dayTitle">
          <a href="https://www.cnblogs.com/huhx/archive/2016/03/19.html">2016年3月19日</a>
        </div>
    
        <div class="postTitle" role="heading" aria-level="2">
          <a class="postTitle2 vertical-middle pinned-post" href="https://www.cnblogs.com/huhx/p/asynctask_theory.html">
        <span>
                <span class="pinned-post-mark">[置顶]</span>
            android高级----&gt;AsyncTask的源码分析
        </span>
    
          </a>
        </div>
        <div class="postCon">
    
          <div class="c_b_p_desc" id="postlist_description_5267805">
            摘要：
            在Android中实现异步任务机制有两种方式，Handler和AsyncTask,今天我们从源码着手去深入地理解AsyncTask的源码，做一个详细的过程分析与总结。对于方法执行的每一步，都比较细致的分析。        <a href="https://www.cnblogs.com/huhx/p/asynctask_theory.html" class="c_b_p_desc_readmore">阅读全文</a>
          </div>
        </div>
        <div class="clear"></div>
        <div class="postDesc">posted @ 2016-03-19 20:50
          huhx
          <span data-post-id="5267805" class="post-view-count">阅读(2209)</span>
          <span data-post-id="5267805" class="post-comment-count">评论(9)</span>
          <span data-post-id="5267805" class="post-digg-count">推荐(11)</span>
          <a href="https://i.cnblogs.com/EditPosts.aspx?postid=5267805" rel="nofollow">
            编辑
          </a>
        </div>
        <div class="clear"></div>
      </div>
    </div>
   ''';

    final List<UserBlog> blogs = UserBlogParser.parseUserBlogList(string);

    expect(blogs.length, 1);
    expect(
      blogs[0],
      UserBlog(
        id: 5267805,
        dayTitle: "2016年3月19日",
        title: '''<span>
                <span class="pinned-post-mark">[置顶]</span>
            android高级----&gt;AsyncTask的源码分析
        </span>''',
        url: "https://www.cnblogs.com/huhx/p/asynctask_theory.html",
        isPinned: true,
        summary: '''在Android中实现异步任务机制有两种方式，Handler和AsyncTask,今天我们从源码着手去深入地理解AsyncTask的源码，做一个详细的过程分析与总结。对于方法执行的每一步，都比较细致的分析。''',
        name: "huhx",
        commentCount: 9,
        diggCount: 11,
        viewCount: 2209,
        postDate: DateTime.parse("2016-03-19 20:50"),
      ),
    );
  });

  test("should return multiple dayTitle user profile blog list", () {
    const String string = '''
    <div class="forFlow">
      <div class="day" role="article" aria-describedby="postlist_description_13406634">
        <div class="dayTitle">
          <a href="https://www.cnblogs.com/huhx/archive/2020/07/30.html">2020年7月30日</a>
        </div>
    
        <div class="postTitle" role="heading" aria-level="2">
          <a class="postTitle2 vertical-middle" href="https://www.cnblogs.com/huhx/p/13388984.html">
            <span>
                android使用----&gt;常用组件1
            </span>
    
          </a>
        </div>
        <div class="postCon">
    
          <div class="c_b_p_desc" id="postlist_description_13388984">
            摘要：
            在TextView中创建空心文字 TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:layout_centerInParent="true" android:shado <a href="https://www.cnblogs.com/huhx/p/13388984.html"
                                                                  class="c_b_p_desc_readmore">阅读全文</a>
          </div>
        </div>
        <div class="clear"></div>
        <div class="postDesc">posted @ 2020-07-30 21:49
          huhx
          <span data-post-id="13388984" class="post-view-count">阅读(378)</span>
          <span data-post-id="13388984" class="post-comment-count">评论(0)</span>
          <span data-post-id="13388984" class="post-digg-count">推荐(0)</span>
          <a href="https://i.cnblogs.com/EditPosts.aspx?postid=13388984" rel="nofollow">
            编辑
          </a>
        </div>
        <div class="clear"></div>
        <div class="postSeparator"></div>
        <div class="postTitle" role="heading" aria-level="2">
          <a class="postTitle2 vertical-middle" href="https://www.cnblogs.com/huhx/p/13406634.html">
            <span>
                flutter feature----&gt;quick action
            </span>
    
          </a>
        </div>
        <div class="postCon">
    
          <div class="c_b_p_desc" id="postlist_description_13406634">
            摘要：
            reference: https://www.filledstacks.com/snippet/managing-quick-actions-in-flutter/ code import 'dart:io'; import
            'package:flutter/material.dart'; impo <a href="https://www.cnblogs.com/huhx/p/13406634.html"
                                                     class="c_b_p_desc_readmore">阅读全文</a>
          </div>
        </div>
        <div class="clear"></div>
        <div class="postDesc">posted @ 2020-07-30 21:48
          huhx
          <span data-post-id="13406634" class="post-view-count">阅读(618)</span>
          <span data-post-id="13406634" class="post-comment-count">评论(0)</span>
          <span data-post-id="13406634" class="post-digg-count">推荐(0)</span>
          <a href="https://i.cnblogs.com/EditPosts.aspx?postid=13406634" rel="nofollow">
            编辑
          </a>
        </div>
        <div class="clear"></div>
      </div>
    </div>
   ''';

    final List<UserBlog> blogs = UserBlogParser.parseUserBlogList(string);

    expect(blogs.length, 2);
    expect(
      blogs[0],
      UserBlog(
        id: 13388984,
        dayTitle: "2020年7月30日",
        title: '''<span>
                android使用----&gt;常用组件1
            </span>''',
        url: "https://www.cnblogs.com/huhx/p/13388984.html",
        isPinned: false,
        summary: '''在TextView中创建空心文字 TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
            android:layout_centerInParent="true" android:shado''',
        name: "huhx",
        commentCount: 0,
        diggCount: 0,
        viewCount: 378,
        postDate: DateTime.parse("2020-07-30 21:49"),
      ),
    );
    expect(
      blogs[1],
      UserBlog(
        id: 13406634,
        dayTitle: "2020年7月30日",
        title: '''<span>
                flutter feature----&gt;quick action
            </span>''',
        url: "https://www.cnblogs.com/huhx/p/13406634.html",
        isPinned: false,
        summary: '''reference: https://www.filledstacks.com/snippet/managing-quick-actions-in-flutter/ code import 'dart:io'; import
            'package:flutter/material.dart'; impo''',
        name: "huhx",
        commentCount: 0,
        diggCount: 0,
        viewCount: 618,
        postDate: DateTime.parse("2020-07-30 21:48"),
      ),
    );
  });
}
