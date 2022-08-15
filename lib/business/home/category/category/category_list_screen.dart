import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/category_api.dart';
import 'package:flutter_cnblog/business/home/blog_item.dart';
import 'package:flutter_cnblog/common/extension/comm_extension.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/custom_paged_builder_delegate.dart';
import 'package:flutter_cnblog/model/blog_category.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryListScreen extends StatefulWidget {
  final CategoryInfo categoryInfo;

  const CategoryListScreen(this.categoryInfo, {Key? key}) : super(key: key);

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  static const int pageSize = 20;
  final PagingController<int, BlogResp> _pagingController = PagingController(firstPageKey: 1);
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    final List<BlogResp> blogs = await categoryApi.getByCategory(pageKey, widget.categoryInfo.url);
    _pagingController.fetch(blogs, pageKey, pageSize: pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: Text(widget.categoryInfo.label),
      ),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: _onRefresh,
        child: PagedListView<int, BlogResp>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<BlogResp>(
            firstPageProgressIndicatorBuilder: (_) => const FirstPageProgressIndicator(),
            newPageProgressIndicatorBuilder: (_) => const NewPageProgressIndicator(),
            noMoreItemsIndicatorBuilder: (_) => const NoMoreItemsIndicator(),
            itemBuilder: (context, item, index) => BlogItem(blog: item),
          ),
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