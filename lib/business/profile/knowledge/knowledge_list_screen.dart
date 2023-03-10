import 'package:app_common_flutter/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/knowledge_api.dart';
import 'package:flutter_cnblog/api/read_log_api.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:app_common_flutter/views.dart';
import 'package:flutter_cnblog/model/detail_model.dart';
import 'package:flutter_cnblog/model/knowledge.dart';
import 'package:flutter_cnblog/model/read_log.dart';
import 'package:intl/intl.dart';

import 'knowledge_detail_screen.dart';

class KnowledgeListScreen extends StatefulWidget {
  const KnowledgeListScreen({super.key});

  @override
  State<KnowledgeListScreen> createState() => _KnowledgeListScreenState();
}

class _KnowledgeListScreenState extends StreamState<KnowledgeListScreen, KnowledgeInfo> {
  @override
  Future<void> fetchPage(int pageKey) async {
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
      body: PagedView(
        streamList,
        (context, knowledgeList) => ListView.builder(
          itemCount: knowledgeList.length,
          itemBuilder: (_, index) => KnowledgeItem(
            knowledgeList[index],
            key: ValueKey(knowledgeList[index].id),
          ),
        ),
      ),
    );
  }
}

class KnowledgeItem extends StatelessWidget {
  final KnowledgeInfo knowledge;

  const KnowledgeItem(this.knowledge, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final DetailModel detailModel = knowledge.toDetail();
        context.goto(KnowledgeDetailScreen(detailModel));
        readLogApi.insert(ReadLog.of(
          type: ReadLogType.knowledge,
          summary: knowledge.summary,
          detailModel: detailModel,
        ));
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                knowledge.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 6),
              Text(
                knowledge.summary,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        knowledge.category,
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
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
