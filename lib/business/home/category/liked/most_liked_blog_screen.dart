import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/blog_api.dart';
import 'package:flutter_cnblog/business/home/blog_detail_screen.dart';
import 'package:flutter_cnblog/business/main/scroll_provider.dart';
import 'package:flutter_cnblog/common/constant/comm_constant.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/popular_blog_resp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

class MostLikedBlogScreen extends ConsumerStatefulWidget {
  const MostLikedBlogScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MostLikedBlogScreen> createState() => _MostLikedBlogScreenState();
}

class _MostLikedBlogScreenState extends ConsumerState<MostLikedBlogScreen> with AutomaticKeepAliveClientMixin {
  final StreamList<PopularBlogResp> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<PopularBlogResp> blogs = await blogApi.getMostLikedBlogs(pageKey, pageSize);
      streamList.fetch(blogs, pageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: streamList.stream,
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final List<PopularBlogResp> blogs = snap.data as List<PopularBlogResp>;

        return SmartRefresher(
          controller: streamList.refreshController,
          onRefresh: () => streamList.onRefresh(),
          onLoading: () => streamList.onLoading(),
          enablePullUp: true,
          child: ListView.builder(
            controller: ref.watch(scrollProvider.notifier).get("blog"),
            itemCount: blogs.length,
            itemBuilder: (_, index) => BlogItem(index: index, blog: blogs[index], key: ValueKey(blogs[index].id)),
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

  @override
  bool get wantKeepAlive => true;
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
                        TextIcon(icon: 'like', counts: blog.viewCount)
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
