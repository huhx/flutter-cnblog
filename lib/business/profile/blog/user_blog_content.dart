import 'package:app_common_flutter/extension.dart';
import 'package:app_common_flutter/pagination.dart';
import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_blog_api.dart';
import 'package:flutter_cnblog/business/profile/blog/user_blog_item.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserBlogContent extends StatefulWidget {
  final UserInfo user;

  const UserBlogContent(this.user, {super.key});

  @override
  State<UserBlogContent> createState() => _UserBlogContentState();
}

class _UserBlogContentState extends StreamState<UserBlogContent, UserBlog> {
  @override
  Future<void> fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<UserBlog> blogs = await userBlogApi.getUserBlogList(widget.user.blogName, pageKey);
      final bool isLastPage = blogs.where((element) => !element.isPinned).length < 10;
      if (isLastPage) {
        streamList.appendLastPage(false, blogs);
      } else {
        final int nextPageKey = pageKey + 1;
        streamList.appendPage(false, blogs, nextPageKey);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamList.stream,
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final List<UserBlog> blogs = snap.data as List<UserBlog>;

        if (blogs.isEmpty) {
          return const EmptyWidget(message: "博客为空");
        }
        final Map<String, List<UserBlog>> blogMap = blogs.where((element) => !element.isPinned).toList().groupBy((blog) => blog.dayTitle);

        return SmartRefresher(
          controller: streamList.refreshController,
          onRefresh: () => streamList.onRefresh(),
          onLoading: () => streamList.onLoading(),
          enablePullUp: true,
          child: ListView.builder(
            itemCount: blogMap.length,
            itemBuilder: (_, index) {
              final String key = blogMap.keys.elementAt(index);
              final List<UserBlog> blogItems = blogMap[key]!;

              return StickyHeader(
                overlapHeaders: false,
                header: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SimpleTextIcon(icon: "read_log", text: key),
                      SimpleTextIcon(icon: "read_log_count", text: "${blogItems.length}篇"),
                    ],
                  ),
                ),
                content: ListView.builder(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => UserBlogItem(
                    userBlog: blogItems[index],
                    userInfo: widget.user,
                    key: ValueKey(blogItems[index].id),
                  ),
                  itemCount: blogItems.length,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
