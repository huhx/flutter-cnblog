import 'package:app_common_flutter/pagination.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class StreamConsumerState<T extends ConsumerStatefulWidget, U> extends ConsumerState<T> {
  final StreamList<U> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => fetchPage(pageKey));
  }

  @protected
  Future<void> fetchPage(int pageKey);

  @override
  void dispose() {
    streamList.dispose();
    super.dispose();
  }
}
