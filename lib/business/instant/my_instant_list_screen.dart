import 'package:app_common_flutter/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/instant_api.dart';
import 'package:flutter_cnblog/model/instant.dart';

import 'instant_item.dart';

class MyInstantListScreen extends StatefulWidget {
  final MyInstantCategory category;

  const MyInstantListScreen(this.category, {super.key});

  @override
  State<MyInstantListScreen> createState() => _MyInstantListScreenState();
}

class _MyInstantListScreenState extends StreamState<MyInstantListScreen, InstantInfo> with AutomaticKeepAliveClientMixin {
  @override
  Future<void> fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<InstantInfo> instants = await instantApi.getMyInstants(widget.category, pageKey);
      streamList.fetch(instants, pageKey, pageSize: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PagedView(
      streamList,
      (context, instants) => ListView.builder(
        itemCount: instants.length,
        itemBuilder: (_, index) => InstantItem(instant: instants[index], key: ValueKey(instants[index].id)),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
