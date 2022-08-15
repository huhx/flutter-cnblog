import 'package:flutter/material.dart';
import 'package:flutter_cnblog/model/news.dart';

import 'news_list_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

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
              Tab(text: "推荐新闻"),
              Tab(text: "热门新闻"),
            ],
            indicatorColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 1,
          ),
        ),
        body: const TabBarView(
          children: [
            NewsListScreen(NewsCategory.lasted),
            NewsListScreen(NewsCategory.recommend),
            NewsListScreen(NewsCategory.hot),
          ],
        ),
      ),
    );
  }
}
