import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/instant_api.dart';
import 'package:flutter_cnblog/business/main/scroll_provider.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/empty_widget.dart';
import 'package:flutter_cnblog/model/instant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'instant_item.dart';

class InstantListScreen extends ConsumerStatefulWidget {
  final InstantCategory category;

  const InstantListScreen(this.category, {Key? key}) : super(key: key);

  @override
  ConsumerState<InstantListScreen> createState() => _InstantListScreenState();
}

class _InstantListScreenState extends ConsumerState<InstantListScreen> with AutomaticKeepAliveClientMixin {
  final StreamList<InstantInfo> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<InstantInfo> instants = await instantApi.getAllInstants(widget.category, pageKey);
      streamList.fetch(instants, pageKey, pageSize: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: streamList.stream,
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final List<InstantInfo> instants = snap.data as List<InstantInfo>;

        if (instants.isEmpty) {
          return const EmptyWidget();
        }

        return SmartRefresher(
          controller: streamList.refreshController,
          onRefresh: () => streamList.onRefresh(),
          onLoading: () => streamList.onLoading(),
          enablePullUp: true,
          child: ListView.builder(
            controller: ref.watch(scrollProvider.notifier).get("instant"),
            itemCount: instants.length,
            itemBuilder: (_, index) => InstantItem(instant: instants[index], key: ValueKey(instants[index].id)),
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

  @override
  bool get wantKeepAlive => true;
}
