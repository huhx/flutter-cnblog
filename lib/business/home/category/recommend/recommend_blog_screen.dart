import 'package:app_common_flutter/pagination.dart';
import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/blog_api.dart';
import 'package:flutter_cnblog/api/read_log_api.dart';
import 'package:flutter_cnblog/business/home/blog_detail_screen.dart';
import 'package:flutter_cnblog/business/main/scroll_provider.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/common/stream_consumer_state.dart';
import 'package:flutter_cnblog/model/blog_content_resp.dart';
import 'package:flutter_cnblog/model/detail_model.dart';
import 'package:flutter_cnblog/model/read_log.dart';
import 'package:flutter_cnblog/model/recommend_blog_resp.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

class RecommendBlogScreen extends StatefulHookConsumerWidget {
  const RecommendBlogScreen({super.key});

  @override
  ConsumerState<RecommendBlogScreen> createState() => _RecommendBlogScreenState();
}

class _RecommendBlogScreenState extends StreamConsumerState<RecommendBlogScreen, RecommendBlogResp> {
  @override
  Future<void> fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<RecommendBlogResp> blogs = await blogApi.getRecommendBlogs(pageKey, 20);
      streamList.fetch(blogs, pageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: true);

    return PagedView(
      streamList,
      (context, blogs) => ListView.builder(
        controller: ref.watch(scrollProvider.notifier).get("blog"),
        itemCount: blogs.length,
        itemBuilder: (_, index) => BlogItem(
          index: index,
          blog: blogs[index],
          key: ValueKey(blogs[index].blogId),
        ),
      ),
    );
  }
}

class BlogItem extends StatelessWidget {
  final int index;
  final RecommendBlogResp blog;

  const BlogItem({required this.index, required this.blog, super.key});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = index < 5 ? Colors.blue : Colors.grey;
    return InkWell(
      onTap: () async {
        final String encodeString = Uri.encodeComponent(blog.url);
        final BlogContentResp blogContentResp = await blogApi.getBlogByUrl(encodeString);
        final DetailModel detailModel = blogContentResp.toBlogResp().toDetail();
        context.goto(BlogDetailScreen(blog: detailModel));
        readLogApi.insert(ReadLog.of(
          type: ReadLogType.blog,
          summary: blogContentResp.description,
          detailModel: detailModel,
        ));
      },
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
                    Text(
                      blog.title,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          timeago.format(blog.dateAdded),
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SvgIcon(name: 'like', size: 12, color: Colors.grey)
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
