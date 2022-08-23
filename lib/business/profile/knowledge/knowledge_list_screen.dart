import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/knowledge_api.dart';
import 'package:flutter_cnblog/common/extension/comm_extension.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/custom_paged_builder_delegate.dart';
import 'package:flutter_cnblog/component/svg_action_icon.dart';
import 'package:flutter_cnblog/model/knowledge.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'knowledge_detail_screen.dart';

class KnowledgeListScreen extends StatefulWidget {
  const KnowledgeListScreen({Key? key}) : super(key: key);

  @override
  State<KnowledgeListScreen> createState() => _KnowledgeListScreenState();
}

class _KnowledgeListScreenState extends State<KnowledgeListScreen> {
  final PagingController<int, KnowledgeInfo> _pagingController = PagingController(firstPageKey: 1);
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    final List<KnowledgeInfo> blogs = await knowledgeApi.getKnowledgeList(pageKey);
    _pagingController.fetch(blogs, pageKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: const Text("知识库"),
        actions: [
          IconButton(
            icon: const SvgActionIcon(name: "bookmark"),
            onPressed: () => CommUtil.toBeDev(),
          )
        ],
      ),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: _onRefresh,
        child: PagedListView<int, KnowledgeInfo>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<KnowledgeInfo>(
            firstPageProgressIndicatorBuilder: (_) => const FirstPageProgressIndicator(),
            newPageProgressIndicatorBuilder: (_) => const NewPageProgressIndicator(),
            noMoreItemsIndicatorBuilder: (_) => const NoMoreItemsIndicator(),
            itemBuilder: (context, item, index) => KnowledgeItem(item),
          ),
        ),
      ),
    );
  }

  void _onRefresh() {
    _pagingController.refresh();
    refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class KnowledgeItem extends StatelessWidget {
  final KnowledgeInfo knowledge;

  const KnowledgeItem(this.knowledge, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goto(KnowledgeDetailScreen(knowledge)),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(knowledge.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
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
