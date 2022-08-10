import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/blog_api.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeCategoryScreen extends StatefulWidget {
  const HomeCategoryScreen({Key? key}) : super(key: key);

  @override
  State<HomeCategoryScreen> createState() => _HomeCategoryScreenState();
}

class _HomeCategoryScreenState extends State<HomeCategoryScreen> {
  static const _pageSize = 10;
  final PagingController<int, BlogResp> _pagingController = PagingController(firstPageKey: 1);
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<BlogResp> blogs = await blogApi.getHomeBlogs(pageKey, _pageSize);
      final isLastPage = blogs.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(blogs);
      } else {
        final int nextPageKey = pageKey + blogs.length;
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
      child: PagedListView<int, BlogResp>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<BlogResp>(
          itemBuilder: (context, item, index) => BlogItem(blog: item),
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
  final BlogResp blog;

  const BlogItem({required this.blog, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(blog.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            const SizedBox(height: 6),
            Text(
              blog.description,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleImage(url: blog.avatar),
                    const SizedBox(width: 4),
                    Text(blog.author, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(width: 10),
                    TextIcon(icon: "view", counts: blog.viewCount),
                    const SizedBox(width: 6),
                    TextIcon(icon: "comment", counts: blog.commentCount),
                    const SizedBox(width: 6),
                    TextIcon(icon: "like", counts: blog.diggCount),
                  ],
                ),
                Text(
                  timeago.format(DateTime.parse(blog.postDate), locale: 'zh_CN'),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TextIcon extends StatelessWidget {
  final String icon;
  final int counts;

  const TextIcon({super.key, required this.icon, required this.counts});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgIcon(name: icon, size: 12, color: Colors.grey),
        const SizedBox(width: 2),
        Text("$counts", style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ],
    );
  }
}
