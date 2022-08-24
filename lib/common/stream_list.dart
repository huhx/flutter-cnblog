import 'dart:async';

import 'package:flutter_cnblog/common/page_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef RequestListener<int> = Future<void> Function(int pageKey);

class StreamList<T> {
  final int firstKey;
  final int pageSize;

  StreamList({this.firstKey = 1, this.pageSize = 20}) {
    pageState = PageState(nextKey: firstKey);
  }

  final StreamController<List<T>?> _streamController = StreamController();

  Stream<List<T>?> get stream => _streamController.stream;

  final RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;

  late PageState<int, T> pageState;
  late RequestListener<int> _listener;

  void addRequestListener(RequestListener<int> requestListener) {
    _listener = requestListener;
    _init();
  }

  Future<void> _init() async {
    pageState = PageState<int, T>(
      nextKey: firstKey,
      error: null,
      itemList: null,
    );
    await _listener(firstKey);
  }

  Future<void> onRefresh() async {
    await _init();

    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    if (pageState.nextKey == null) {
      refreshController.loadComplete();
      return;
    }
    await _listener(pageState.nextKey!);

    refreshController.loadComplete();
  }

  void fetch(List<T> list, int pageKey) {
    final bool isLastPage = list.length < pageSize;
    if (isLastPage) {
      appendLastPage(list);
    } else {
      appendPage(list, pageKey + 1);
    }
  }

  void appendLastPage(List<T> newItems) => appendPage(newItems, null);

  void appendPage(List<T> newItems, int? nextPageKey) {
    final previousItems = pageState.itemList ?? [];
    final itemList = previousItems + newItems;
    pageState = PageState<int, T>(
      itemList: itemList,
      error: null,
      nextKey: nextPageKey,
    );

    _streamController.add(itemList);
  }

  void dispose() {
    _refreshController.dispose();
    _streamController.close();
  }
}
