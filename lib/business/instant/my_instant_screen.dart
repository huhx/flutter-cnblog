import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/model/instant.dart';

import 'my_instant_list_screen.dart';

class MyInstantScreen extends StatelessWidget {
  const MyInstantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppbarBackButton(),
          title: const TabBar(
            tabs: [
              Tab(text: "回复我"),
              Tab(text: "提到我"),
              Tab(text: "我发布"),
            ],
            indicatorColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 1,
          ),
        ),
        body: const TabBarView(
          children: [
            MyInstantListScreen(MyInstantCategory.comment),
            MyInstantListScreen(MyInstantCategory.mention),
            MyInstantListScreen(MyInstantCategory.publish),
          ],
        ),
      ),
    );
  }
}
