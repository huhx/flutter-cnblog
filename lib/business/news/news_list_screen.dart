import 'package:app_common_flutter/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/news_api.dart';
import 'package:flutter_cnblog/business/main/scroll_provider.dart';
import 'package:flutter_cnblog/common/stream_consumer_state.dart';
import 'package:flutter_cnblog/model/news.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'news_item.dart';

class NewsListScreen extends StatefulHookConsumerWidget {
  final NewsCategory category;

  const NewsListScreen(this.category, {super.key});

  @override
  ConsumerState<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends StreamConsumerState<NewsListScreen, NewsInfo> {
  @override
  Future<void> fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<NewsInfo> newsList = await newsApi.getAllNewses(widget.category, pageKey);
      streamList.fetch(newsList, pageKey, pageSize: widget.category.pageSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: true);

    return PagedView(
      streamList,
      (context, newsList) => ListView.builder(
        controller: ref.watch(scrollProvider.notifier).get("news"),
        itemCount: newsList.length,
        itemBuilder: (_, index) => NewsItem(news: newsList[index], key: ValueKey(newsList[index].id)),
      ),
    );
  }
}
