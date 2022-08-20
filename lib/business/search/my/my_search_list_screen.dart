import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/search_api.dart';
import 'package:flutter_cnblog/common/extension/comm_extension.dart';
import 'package:flutter_cnblog/component/custom_paged_builder_delegate.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MySearchListScreen extends StatefulWidget {
  final MySearchType searchType;
  final String keyword;

  const MySearchListScreen(this.searchType, this.keyword, {Key? key}) : super(key: key);

  @override
  State<MySearchListScreen> createState() => _MySearchListScreenState();
}

class _MySearchListScreenState extends State<MySearchListScreen> {
  final PagingController<int, SearchInfo> _pagingController = PagingController(firstPageKey: 1);
  final RefreshController refreshController = RefreshController();
  static const int pageSize = 10;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    final List<SearchInfo> blogs = await searchApi.getMySearchContents(widget.searchType, pageKey, widget.keyword);
    _pagingController.fetch(blogs, pageKey, pageSize: pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: _onRefresh,
      child: PagedListView<int, SearchInfo>(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<SearchInfo>(
          firstPageProgressIndicatorBuilder: (_) => const FirstPageProgressIndicator(),
          newPageProgressIndicatorBuilder: (_) => const NewPageProgressIndicator(),
          noMoreItemsIndicatorBuilder: (_) => const NoMoreItemsIndicator(),
          itemBuilder: (context, item, index) => MySearchItem(item),
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

class MySearchItem extends StatelessWidget {
  final SearchInfo searchInfo;

  const MySearchItem(this.searchInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CommUtil.toBeDev(),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          child: Column(
            children: [
              Html(data: searchInfo.title),
              Html(data: searchInfo.summary),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (searchInfo.author != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            searchInfo.author!,
                            style: const TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      if (searchInfo.diggCount != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            searchInfo.diggCount!.toString(),
                            style: const TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      if (searchInfo.commentCount != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            searchInfo.commentCount!.toString(),
                            style: const TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Text(
                          searchInfo.viewCount.toString(),
                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                  Text(searchInfo.postDate)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
