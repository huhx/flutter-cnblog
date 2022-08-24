import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/instant_api.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/model/instant.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'instant_item.dart';

class MyInstantListScreen extends StatefulWidget {
  final MyInstantCategory category;

  const MyInstantListScreen(this.category, {Key? key}) : super(key: key);

  @override
  State<MyInstantListScreen> createState() => _MyInstantListScreenState();
}

class _MyInstantListScreenState extends State<MyInstantListScreen> {
  final StreamList<InstantInfo> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<InstantInfo> instants = await instantApi.getMyInstants(widget.category, pageKey);
      streamList.fetch(instants, pageKey, pageSize: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamList.stream,
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final List<InstantInfo> instants = snap.data as List<InstantInfo>;

        return SmartRefresher(
          controller: streamList.refreshController,
          onRefresh: () => streamList.onRefresh(),
          onLoading: () => streamList.onLoading(),
          enablePullUp: true,
          child: ListView.builder(
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
}
