import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_blog_api.dart';
import 'package:flutter_cnblog/business/profile/blog/user_blog_item.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/empty_widget.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserBlogContent extends StatefulWidget {
  final UserInfo user;

  const UserBlogContent(this.user, {Key? key}) : super(key: key);

  @override
  State<UserBlogContent> createState() => _UserBlogContentState();
}

class _UserBlogContentState extends State<UserBlogContent> {
  final StreamList<UserBlog> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<UserBlog> blogs = await userBlogApi.getUserBlogList(widget.user.blogName, pageKey);
      final bool isLastPage = blogs.where((element) => !element.isPinned).length < 10;
      if (isLastPage) {
        streamList.appendLastPage(blogs);
      } else {
        final int nextPageKey = pageKey + 1;
        streamList.appendPage(blogs, nextPageKey);
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
          return const EmptyWidget();
        }
        return SmartRefresher(
          controller: streamList.refreshController,
          onRefresh: () => streamList.onRefresh(),
          onLoading: () => streamList.onLoading(),
          enablePullUp: true,
          child: ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (_, index) => UserBlogItem(userBlog: blogs[index], key: ValueKey(blogs[index].id)),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    streamList.dispose();
    super.dispose();
  }
}
