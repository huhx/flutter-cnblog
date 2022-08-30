import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/question_api.dart';
import 'package:flutter_cnblog/business/main/scroll_provider.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/empty_widget.dart';
import 'package:flutter_cnblog/model/question.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'question_item.dart';

class QuestionListScreen extends ConsumerStatefulWidget {
  final QuestionStatus status;

  const QuestionListScreen(this.status, {super.key});

  @override
  ConsumerState<QuestionListScreen> createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends ConsumerState<QuestionListScreen> with AutomaticKeepAliveClientMixin {
  final StreamList<QuestionInfo> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<QuestionInfo> questions = await questionApi.getAllQuestions(widget.status, pageKey);
      streamList.fetch(questions, pageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: streamList.stream,
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final List<QuestionInfo> questions = snap.data as List<QuestionInfo>;

        if (questions.isEmpty) {
          return const EmptyWidget();
        }

        return SmartRefresher(
          controller: streamList.refreshController,
          onRefresh: () => streamList.onRefresh(),
          onLoading: () => streamList.onLoading(),
          enablePullUp: true,
          child: ListView.builder(
            controller: ref.watch(scrollProvider.notifier).get("question"),
            itemCount: questions.length,
            itemBuilder: (_, index) => QuestionItem(question: questions[index], key: ValueKey(questions[index].id)),
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

  @override
  bool get wantKeepAlive => true;
}
