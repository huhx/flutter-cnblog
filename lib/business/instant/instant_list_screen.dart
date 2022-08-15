import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/instant_api.dart';
import 'package:flutter_cnblog/common/extension/comm_extension.dart';
import 'package:flutter_cnblog/component/custom_paged_builder_delegate.dart';
import 'package:flutter_cnblog/model/instant.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'instant_item.dart';

class InstantListScreen extends StatefulWidget {
  final InstantCategory category;

  const InstantListScreen(this.category, {Key? key}) : super(key: key);

  @override
  State<InstantListScreen> createState() => _InstantListScreenState();
}

class _InstantListScreenState extends State<InstantListScreen> {
  final PagingController<int, InstantInfo> _pagingController = PagingController(firstPageKey: 1);
  final RefreshController refreshController = RefreshController();
  static const int pageSize = 30;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    final List<InstantInfo> blogs = await instantApi.getAllInstants(widget.category, pageKey);
    _pagingController.fetch(blogs, pageKey, pageSize: pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: _onRefresh,
      child: PagedListView<int, InstantInfo>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<InstantInfo>(
          firstPageProgressIndicatorBuilder: (_) => const FirstPageProgressIndicator(),
          newPageProgressIndicatorBuilder: (_) => const NewPageProgressIndicator(),
          noMoreItemsIndicatorBuilder: (_) => const NoMoreItemsIndicator(),
          itemBuilder: (context, item, index) => InstantItem(instant: item),
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
