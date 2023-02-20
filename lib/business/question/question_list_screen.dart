import 'package:app_common_flutter/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/question_api.dart';
import 'package:flutter_cnblog/business/main/scroll_provider.dart';
import 'package:flutter_cnblog/common/stream_consumer_state.dart';
import 'package:flutter_cnblog/model/question.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'question_item.dart';

class QuestionListScreen extends StatefulHookConsumerWidget {
  final QuestionStatus status;

  const QuestionListScreen(this.status, {super.key});

  @override
  ConsumerState<QuestionListScreen> createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends StreamConsumerState<QuestionListScreen, QuestionInfo> {
  @override
  Future<void> fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<QuestionInfo> questions = await questionApi.getAllQuestions(widget.status, pageKey);
      streamList.fetch(questions, pageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: true);

    return PagedView(
      streamList,
      (context, questions) => ListView.builder(
        controller: ref.watch(scrollProvider.notifier).get("question"),
        itemCount: questions.length,
        itemBuilder: (_, index) => QuestionItem(question: questions[index], key: ValueKey(questions[index].id)),
      ),
    );
  }
}
