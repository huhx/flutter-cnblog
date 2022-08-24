import 'dart:async';

import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef RequestListener<int> = Future<void> Function(int pageKey);

class StreamList<T> {
  final int firstKey;
  final int pageSize;

  StreamList({required this.firstKey, required this.pageSize});

  final StreamController<List<T>> _streamController = StreamController();

  Stream<List<T>> get stream => _streamController.stream;

  final RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;

  final List<T> data = [];
  int nextKey = 1;
  bool hasNext = true;
  late RequestListener<int> _listener;

  void addRequestListener(RequestListener<int> requestListener) {
    _listener = requestListener;
    init();
  }

  Future<void> onRefresh() async {
    data.clear();
    await _listener(firstKey);
    nextKey = firstKey + 1;

    refreshController.refreshCompleted();
  }

  Future<void> init() async {
    data.clear();
    await _listener(firstKey);
    nextKey = firstKey;

    if (hasNext = data.length == pageSize) {
      nextKey++;
    }
  }

  Future<void> onLoading() async {
    if (!hasNext) {
      refreshController.loadComplete();
      return;
    }
    await _listener(nextKey);
    if (hasNext = data.length == pageSize) {
      nextKey++;
    }

    refreshController.loadComplete();
  }

  void addAll(List<T> list) {
    data.addAll(list);
    if (hasNext = list.length == pageSize) {
      nextKey++;
    }

    dispatch();
  }

  void dispatch() {
    _streamController.add(data);
  }

  void dispose() {
    _refreshController.dispose();
    _streamController.close();
  }
}
