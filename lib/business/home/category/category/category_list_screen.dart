import 'package:app_common_flutter/pagination.dart';
import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/category_api.dart';
import 'package:flutter_cnblog/business/home/blog_item.dart';
import 'package:flutter_cnblog/business/main/scroll_provider.dart';
import 'package:flutter_cnblog/common/stream_consumer_state.dart';
import 'package:flutter_cnblog/model/blog_category.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryListScreen extends ConsumerStatefulWidget {
  final CategoryInfo categoryInfo;

  const CategoryListScreen(this.categoryInfo, {super.key});

  @override
  ConsumerState<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends StreamConsumerState<CategoryListScreen, BlogResp> {
  @override
  Future<void> fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<BlogResp> blogs = await categoryApi.getByCategory(pageKey, widget.categoryInfo.url);
      streamList.fetch(blogs, pageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: Text(widget.categoryInfo.label),
      ),
      body: PagedView(
        streamList,
        (context, blogs) => ListView.builder(
          controller: ref.watch(scrollProvider.notifier).get("blog"),
          itemCount: blogs.length,
          itemBuilder: (_, index) => BlogItem(blog: blogs[index], key: ValueKey(blogs[index].id)),
        ),
      ),
    );
  }
}
