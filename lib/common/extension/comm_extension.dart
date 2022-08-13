import 'package:flutter_cnblog/common/constant/comm_constant.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

extension PageExtension<T> on PagingController<int, T> {
  void fetch(List<T> data, int pageKey, {int pageSize = pageSize}) {
    final isLastPage = data.length < pageSize;
    if (isLastPage) {
      appendLastPage(data);
    } else {
      final int nextPageKey = pageKey + 1;
      appendPage(data, nextPageKey);
    }
  }
}
