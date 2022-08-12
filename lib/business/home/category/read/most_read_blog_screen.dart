import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/blog_api.dart';
import 'package:flutter_cnblog/business/home/blog_detail_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/custom_paged_builder_delegate.dart';
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/popular_blog_resp.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

class MostReadBlogScreen extends StatefulWidget {
  const MostReadBlogScreen({Key? key}) : super(key: key);

  @override
  State<MostReadBlogScreen> createState() => _MostReadBlogScreenState();
}

class _MostReadBlogScreenState extends State<MostReadBlogScreen> {
  static const _pageSize = 10;
  final PagingController<int, PopularBlogResp> _pagingController = PagingController(firstPageKey: 1);
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<PopularBlogResp> blogs = await blogApi.getMostReadBlogs(pageKey, _pageSize);
      final isLastPage = blogs.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(blogs);
      } else {
        final int nextPageKey = pageKey + 1;
        _pagingController.appendPage(blogs, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: _onRefresh,
      child: PagedListView<int, PopularBlogResp>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<PopularBlogResp>(
          firstPageProgressIndicatorBuilder: (_) => const FirstPageProgressIndicator(),
          newPageProgressIndicatorBuilder: (_) => const NewPageProgressIndicator(),
          noMoreItemsIndicatorBuilder: (_) => const NoMoreItemsIndicator(),
          itemBuilder: (context, item, index) => BlogItem(index: index, blog: item),
        ),
      ),
    );
  }

  void _onRefresh() async {
    setState(() {});
    refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class BlogItem extends StatelessWidget {
  final int index;
  final PopularBlogResp blog;

  const BlogItem({required this.index, required this.blog, super.key});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = index < 5 ? Colors.blue : Colors.grey;
    return InkWell(
      onTap: () => context.goto(BlogDetailScreen(blog: blog.toBlogResp())),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: backgroundColor,
                foregroundColor: Colors.white,
                child: Text("${index + 1}"),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(blog.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${blog.author}   ${timeago.format(blog.dateAdded)}",
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        TextIcon(icon: 'view', counts: blog.viewCount)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
