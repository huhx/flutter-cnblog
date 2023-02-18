import 'package:app_common_flutter/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_blog_api.dart';
import 'package:flutter_cnblog/business/profile/blog/user_blog_item.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/model/user_blog.dart';

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
    return PagedView(
      streamList,
      (context, blogs) => ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (_, index) => UserBlogItem(userBlog: blogs[index], userInfo: widget.user, key: ValueKey(blogs[index].id)),
      ),
    );
  }
}
