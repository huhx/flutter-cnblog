import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_blog_api.dart';
import 'package:flutter_cnblog/business/home/blog_item.dart';
import 'package:flutter_cnblog/business/main/scroll_provider.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/empty_widget.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeBlogListScreen extends ConsumerStatefulWidget {
  final BlogCategory category;

  const HomeBlogListScreen(this.category, {super.key});

  @override
  ConsumerState<HomeBlogListScreen> createState() => _HomeBlogListScreenState();
}

class _HomeBlogListScreenState extends ConsumerState<HomeBlogListScreen> with AutomaticKeepAliveClientMixin {
  final StreamList<BlogResp> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<BlogResp> blogList = await userBlogApi.getBlogs(widget.category, pageKey);
      streamList.fetch(blogList, pageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: streamList.stream,
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final List<BlogResp> blogs = snap.data as List<BlogResp>;

        if (blogs.isEmpty) {
          return const EmptyWidget();
        }

        return SmartRefresher(
          controller: streamList.refreshController,
          onRefresh: () => streamList.onRefresh(),
          onLoading: () => streamList.onLoading(),
          enablePullUp: true,
          child: ListView.builder(
            controller: ref.watch(scrollProvider.notifier).get("blog"),
            itemCount: blogs.length,
            itemBuilder: (_, index) => BlogItem(blog: blogs[index], key: ValueKey(blogs[index].id)),
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
