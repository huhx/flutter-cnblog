import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/business/user/login/login_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/svg_action_icon.dart';
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
            IconButton(
              onPressed: () async {
                if (user == null) {
                  await context.goto(const LoginScreen());
                }
                context.goto(const MyQuestionListScreen());
              },
              icon: const SvgActionIcon(name: "mine"),
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
