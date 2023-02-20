import 'dart:async';

import 'package:app_common_flutter/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_blog_api.dart';
import 'package:flutter_cnblog/business/home/blog_item.dart';
import 'package:flutter_cnblog/business/main/scroll_provider.dart';
import 'package:flutter_cnblog/common/stream_consumer_state.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeBlogListScreen extends StatefulHookConsumerWidget {
  final BlogCategory category;

  const HomeBlogListScreen(this.category, {super.key});

  @override
  ConsumerState<HomeBlogListScreen> createState() => _HomeBlogListScreenState();
}

class _HomeBlogListScreenState extends StreamConsumerState<HomeBlogListScreen, BlogResp> {
  @override
  Future<void> fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<BlogResp> blogList = await userBlogApi.getBlogs(widget.category, pageKey);
      streamList.fetch(blogList, pageKey);
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
        itemBuilder: (_, index) => BlogItem(blog: blogs[index], key: ValueKey(blogs[index].id)),
      ),
    );
  }
}
