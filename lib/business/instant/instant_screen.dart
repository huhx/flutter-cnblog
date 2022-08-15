import 'package:flutter/material.dart';
import 'package:flutter_cnblog/model/instant.dart';

import 'instant_list_screen.dart';

class InstantScreen extends StatelessWidget {
  const InstantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const TabBar(
            tabs: [
              Tab(text: "最新发布"),
              Tab(text: "最新评论"),
              Tab(text: "我的关注"),
            ],
            indicatorColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 1,
          ),
        ),
        body: const TabBarView(
          children: [
            InstantListScreen(InstantCategory.all),
            InstantListScreen(InstantCategory.newComment),
            InstantListScreen(InstantCategory.following),
          ],
        ),
      ),
    );
  }
}
