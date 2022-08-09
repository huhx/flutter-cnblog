import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/home/home_category_screen.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';

import 'data/home_category.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            tabs: [
              Tab(text: "首页"),
              Tab(text: "阅读榜"),
              Tab(text: "推荐榜"),
              Tab(text: "Java"),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: const TabBarView(
          children: [
            HomeCategoryScreen(category: HomeCategory.home),
            HomeCategoryScreen(category: HomeCategory.readRank),
            HomeCategoryScreen(category: HomeCategory.recommendRank),
            HomeCategoryScreen(category: HomeCategory.java),
          ],
        ),
      ),
    );
  }
}
