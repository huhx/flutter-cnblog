import 'package:app_common_flutter/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/instant_api.dart';
import 'package:flutter_cnblog/business/main/scroll_provider.dart';
import 'package:flutter_cnblog/common/stream_consumer_state.dart';
import 'package:flutter_cnblog/model/instant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'instant_item.dart';

class InstantListScreen extends ConsumerStatefulWidget {
  final InstantCategory category;

  const InstantListScreen(this.category, {super.key});

  @override
  ConsumerState<InstantListScreen> createState() => _InstantListScreenState();
}

class _InstantListScreenState extends StreamConsumerState<InstantListScreen, InstantInfo> with AutomaticKeepAliveClientMixin {
  @override
  Future<void> fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<InstantInfo> instants = await instantApi.getAllInstants(widget.category, pageKey);
      streamList.fetch(instants, pageKey, pageSize: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PagedView(
      streamList,
      (context, instants) => ListView.builder(
        controller: ref.watch(scrollProvider.notifier).get("instant"),
        itemCount: instants.length,
        itemBuilder: (_, index) => InstantItem(instant: instants[index], key: ValueKey(instants[index].id)),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
