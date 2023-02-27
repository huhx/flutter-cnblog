import 'package:app_common_flutter/constant.dart';
import 'package:app_common_flutter/extension.dart';
import 'package:app_common_flutter/pagination.dart';
import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/read_log_api.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/model/read_log.dart';
import 'package:flutter_cnblog/util/date_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'read_log_slidable.dart';

class ReadLogListScreen extends StatefulWidget {
  const ReadLogListScreen({super.key});

  @override
  State<ReadLogListScreen> createState() => _ReadLogListScreenState();
}

class _ReadLogListScreenState extends StreamState<ReadLogListScreen, ReadLog> {
  @override
  Future<void> fetchPage(int pageKey) async {
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
          SvgActionIcon(
            package: Comm.package,
            name: "delete",
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
          final Map<String, List<ReadLog>> readLogMap = readLogs.groupBy((readLog) => readLog.createTime.dateString);

          return SlidableAutoCloseBehavior(
            child: SmartRefresher(
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
            ),
          );
        },
      ),
    );
  }
}
