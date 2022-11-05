import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/read_log_api.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/common/extension/int_extension.dart';
import 'package:flutter_cnblog/common/extension/list_extension.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/empty_widget.dart';
import 'package:flutter_cnblog/component/svg_action_icon.dart';
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/read_log.dart';
import 'package:flutter_cnblog/util/date_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'read_log_slidable.dart';

class ReadLogListScreen extends StatefulWidget {
  const ReadLogListScreen({Key? key}) : super(key: key);

  @override
  State<ReadLogListScreen> createState() => _ReadLogListScreenState();
}

class _ReadLogListScreenState extends State<ReadLogListScreen> {
  final StreamList<ReadLog> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<ReadLog> readLogs = await readLogApi.queryReadLogs(pageKey);
      streamList.fetch(readLogs, pageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: const Text("阅读记录"),
        actions: [
          IconButton(
            onPressed: () {
              context.showCommDialog(
                callback: () async {
                  await readLogApi.deleteAll();
                  streamList.reset([]);
                },
                title: '清空记录',
                content: '你确定清空阅读记录?',
              );
            },
            icon: const SvgActionIcon(name: "delete"),
          )
        ],
      ),
      body: StreamBuilder(
        stream: streamList.stream,
        builder: (context, snap) {
          if (!snap.hasData) return const CenterProgressIndicator();
          final List<ReadLog> readLogs = snap.data as List<ReadLog>;

          if (readLogs.isEmpty) {
            return const EmptyWidget(message: "阅读记录为空");
          }
          final Map<String, List<ReadLog>> readLogMap =
              readLogs.groupBy((readLog) => readLog.createTime.toDateString());

          return SmartRefresher(
            controller: streamList.refreshController,
            onRefresh: () => streamList.onRefresh(),
            onLoading: () => streamList.onLoading(),
            enablePullUp: true,
            child: ListView.builder(
              itemCount: readLogMap.length,
              itemBuilder: (_, index) {
                final String key = readLogMap.keys.elementAt(index);
                final List<ReadLog> readLogItems = readLogMap[key]!;

                return StickyHeader(
                  overlapHeaders: false,
                  header: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SimpleTextIcon(icon: "read_log", text: key),
                        SimpleTextIcon(icon: "weekday", text: DateUtil.getWeekFromString(key)),
                      ],
                    ),
                  ),
                  content: ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                    return ReadLogSlidable(
                      readlog: readLogItems[index],
                      key: ValueKey(readLogItems[index].id),
                      onDelete: (id) async {
                        streamList.reset(readLogs.where((element) => element.id != id).toList());
                        await readLogApi.delete(id);
                      },
                    );
                    },
                    itemCount: readLogItems.length,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    streamList.dispose();
    super.dispose();
  }
}
