import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/business/user/login/login_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/model/question.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'my/my_question_list_screen.dart';
import 'question_list_screen.dart';

class QuestionScreen extends ConsumerWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(sessionProvider);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const TabBar(
            tabs: [
              Tab(text: "待解决"),
              Tab(text: "高奖励"),
              Tab(text: "零回答"),
              Tab(text: "已解决"),
            ],
            indicatorColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 1,
          ),
          actions: [
            SvgActionIcon(
              name: "mine",
              onPressed: () async {
                if (user == null) {
                  final bool? isSuccess = await context.gotoLogin(const LoginScreen());
                  if (isSuccess == null) return;
                }
                context.goto(const MyQuestionListScreen());
              },
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            QuestionListScreen(QuestionStatus.unresolved),
            QuestionListScreen(QuestionStatus.reward),
            QuestionListScreen(QuestionStatus.noAnswer),
            QuestionListScreen(QuestionStatus.resolved),
          ],
        ),
      ),
    );
  }
}
