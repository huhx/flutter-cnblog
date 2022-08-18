import 'package:flutter/material.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/question.dart';

import 'my/my_question_list_screen.dart';
import 'question_list_screen.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: TabBar(
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
              ),
              InkWell(
                onTap: () => context.goto(const MyQuestionListScreen()),
                child: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: SvgIcon(name: "category_more", color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
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
