import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/question_api.dart';
import 'package:flutter_cnblog/common/extension/comm_extension.dart';
import 'package:flutter_cnblog/component/custom_paged_builder_delegate.dart';
import 'package:flutter_cnblog/model/question.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'question_item.dart';

class QuestionListScreen extends StatefulWidget {
  final QuestionStatus status;

  const QuestionListScreen(this.status, {Key? key}) : super(key: key);

  @override
  State<QuestionListScreen> createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  static const int pageSize = 20;
  final PagingController<int, QuestionInfo> _pagingController = PagingController(firstPageKey: 1);
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    final List<QuestionInfo> questions = await questionApi.getAllQuestions(widget.status, pageKey);
    _pagingController.fetch(questions, pageKey, pageSize: pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: _onRefresh,
      child: PagedListView<int, QuestionInfo>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<QuestionInfo>(
          firstPageProgressIndicatorBuilder: (_) => const FirstPageProgressIndicator(),
          newPageProgressIndicatorBuilder: (_) => const NewPageProgressIndicator(),
          noMoreItemsIndicatorBuilder: (_) => const NoMoreItemsIndicator(),
          itemBuilder: (context, item, index) => QuestionItem(question: item),
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
