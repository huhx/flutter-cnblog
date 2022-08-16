import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_blog_api.dart';
import 'package:flutter_cnblog/business/profile/blog/user_blog_item.dart';
import 'package:flutter_cnblog/component/custom_paged_builder_delegate.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserBlogContent extends StatefulWidget {
  final User user;

  const UserBlogContent(this.user, {Key? key}) : super(key: key);

  @override
  State<UserBlogContent> createState() => _UserBlogContentState();
}

class _UserBlogContentState extends State<UserBlogContent> {
  static const int pageSize = 10;
  final PagingController<int, UserBlog> _pagingController = PagingController(firstPageKey: 1);
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    final List<UserBlog> blogs = await userBlogApi.getUserBlogList(pageKey);
    final bool isLastPage = blogs.where((element) => !element.isPinned).length < pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(blogs);
    } else {
      final int nextPageKey = pageKey + 1;
      _pagingController.appendPage(blogs, nextPageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: _onRefresh,
      child: PagedListView<int, UserBlog>(
        pagingController: _pagingController,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        builderDelegate: PagedChildBuilderDelegate<UserBlog>(
          firstPageProgressIndicatorBuilder: (_) => const FirstPageProgressIndicator(),
          newPageProgressIndicatorBuilder: (_) => const NewPageProgressIndicator(),
          noMoreItemsIndicatorBuilder: (_) => const NoMoreItemsIndicator(),
          itemBuilder: (context, item, index) => UserBlogItem(userBlog: item),
        ),
      ),
    );
  }

  void _onRefresh() {
    _pagingController.refresh();
    refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
