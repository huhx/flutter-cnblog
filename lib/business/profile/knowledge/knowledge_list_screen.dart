import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/knowledge_api.dart';
import 'package:flutter_cnblog/api/read_log_api.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/empty_widget.dart';
import 'package:flutter_cnblog/model/detail_model.dart';
import 'package:flutter_cnblog/model/knowledge.dart';
import 'package:flutter_cnblog/model/read_log.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'knowledge_detail_screen.dart';

class KnowledgeListScreen extends StatefulWidget {
  const KnowledgeListScreen({Key? key}) : super(key: key);

  @override
  State<KnowledgeListScreen> createState() => _KnowledgeListScreenState();
}

class _KnowledgeListScreenState extends State<KnowledgeListScreen> {
  final StreamList<KnowledgeInfo> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<KnowledgeInfo> knowledgeList = await knowledgeApi.getKnowledgeList(pageKey);
      streamList.fetch(knowledgeList, pageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: const Text("知识库"),
      ),
      body: StreamBuilder(
        stream: streamList.stream,
        builder: (context, snap) {
          if (!snap.hasData) return const CenterProgressIndicator();
          final List<KnowledgeInfo> knowledgeList = snap.data as List<KnowledgeInfo>;

          if (knowledgeList.isEmpty) {
            return const EmptyWidget();
          }

          return SmartRefresher(
            controller: streamList.refreshController,
            onRefresh: () => streamList.onRefresh(),
            onLoading: () => streamList.onLoading(),
            enablePullUp: true,
            child: ListView.builder(
              itemCount: knowledgeList.length,
              itemBuilder: (_, index) => KnowledgeItem(knowledgeList[index], key: ValueKey(knowledgeList[index].id)),
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

class KnowledgeItem extends StatelessWidget {
  final KnowledgeInfo knowledge;

  const KnowledgeItem(this.knowledge, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DetailModel detailModel = knowledge.toDetail();
        await readLogApi.insert(ReadLog.of(type: ReadLogType.knowledge, summary: knowledge.summary, detailModel: detailModel));
        context.goto(KnowledgeDetailScreen(detailModel));
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(knowledge.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              const SizedBox(height: 6),
              Text(
                knowledge.summary,
                maxLines: 2,
                style: const TextStyle(fontSize: 13, color: Colors.grey, overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(knowledge.category, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                      const SizedBox(width: 6),
                      Text(
                        "阅读(${knowledge.viewCount})",
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "推荐(${knowledge.diggCount})",
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                  Text(
                    DateFormat("yyyy-MM-dd hh:mm").format(knowledge.postDate),
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
