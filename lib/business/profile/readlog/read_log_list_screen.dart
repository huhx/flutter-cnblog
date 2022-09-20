import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/read_log_api.dart';
import 'package:flutter_cnblog/business/home/blog_detail_screen.dart';
import 'package:flutter_cnblog/business/news/news_detail_screen.dart';
import 'package:flutter_cnblog/business/profile/knowledge/knowledge_detail_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/common/extension/int_extension.dart';
import 'package:flutter_cnblog/common/extension/list_extension.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/empty_widget.dart';
import 'package:flutter_cnblog/component/svg_action_icon.dart';
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/detail_model.dart';
import 'package:flutter_cnblog/model/read_log.dart';
import 'package:flutter_cnblog/util/date_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

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
            return const EmptyWidget();
          }
          final Map<String, List<ReadLog>> readLogMap = readLogs.groupBy((readLog) => readLog.createTime.toDateString());

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

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SimpleTextIcon(icon: "read_log", text: key),
                                SimpleTextIcon(icon: "weekday", text: DateUtil.getWeekFromString(key)),
                              ],
                            ),
                          ),
                          ReadLogItem(readLogItems[index], key: ValueKey(readLogItems[index].id)),
                        ],
                      );
                    }
                    return ReadLogItem(readLogItems[index], key: ValueKey(readLogItems[index].id));
                  },
                  itemCount: readLogItems.length,
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

class ReadLogItem extends StatelessWidget {
  final ReadLog readLog;

  const ReadLogItem(this.readLog, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailModel detailModel = readLog.json;

    return InkWell(
      onTap: () {
        if (readLog.type == ReadLogType.blog) {
          context.goto(BlogDetailScreen(blog: detailModel));
          readLogApi.insert(ReadLog.of(type: ReadLogType.blog, summary: readLog.summary, detailModel: detailModel));
        } else if (readLog.type == ReadLogType.news) {
          context.goto(NewsDetailScreen(detailModel));
          readLogApi.insert(ReadLog.of(type: ReadLogType.news, summary: readLog.summary, detailModel: detailModel));
        } else if (readLog.type == ReadLogType.knowledge) {
          context.goto(KnowledgeDetailScreen(detailModel));
          readLogApi.insert(ReadLog.of(type: ReadLogType.knowledge, summary: readLog.summary, detailModel: detailModel));
        }
      },
      onLongPress: () {
        context.showCommDialog(
          callback: () async {
            await readLogApi.delete(readLog);
          },
          title: '删除记录',
          content: '你确定删除该条阅读记录?',
        );
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.7),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(readLog.type.label, style: const TextStyle(fontSize: 13)),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      detailModel.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                readLog.summary,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(detailModel.name ?? "unKnow", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ),
                      if (detailModel.diggCount != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: TextIcon(icon: "like", counts: detailModel.diggCount!),
                        ),
                      if (detailModel.commentCount != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: TextIcon(icon: "comment", counts: detailModel.commentCount!),
                        ),
                      if (detailModel.viewCount != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: TextIcon(icon: "view", counts: detailModel.viewCount!),
                        ),
                    ],
                  ),
                  Text(
                    timeago.format(DateTime.fromMillisecondsSinceEpoch(readLog.createTime)),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
