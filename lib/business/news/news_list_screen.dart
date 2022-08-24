import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/news_api.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/model/news.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'news_item.dart';

class NewsListScreen extends StatefulWidget {
  final NewsCategory category;

  const NewsListScreen(this.category, {Key? key}) : super(key: key);

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final StreamList<NewsInfo> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<NewsInfo> newsList = await newsApi.getAllNewses(widget.category, pageKey);
      streamList.fetch(newsList, pageKey, pageSize: widget.category.pageSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamList.stream,
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final List<NewsInfo> newsList = snap.data as List<NewsInfo>;

        return SmartRefresher(
          controller: streamList.refreshController,
          onRefresh: () => streamList.onRefresh(),
          onLoading: () => streamList.onLoading(),
          enablePullUp: true,
          child: ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (_, index) => NewsItem(news: newsList[index], key: ValueKey(newsList[index].id)),
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
}
