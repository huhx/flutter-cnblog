import 'package:flutter/material.dart';

import 'category/home/home_category_screen.dart';
import 'category/liked/most_liked_blog_screen.dart';
import 'category/read/most_read_blog_screen.dart';
import 'category/recommend/recommend_blog_screen.dart';

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
              Tab(text: "编辑推荐"),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: const TabBarView(
          children: [
            HomeCategoryScreen(),
            MostReadBlogScreen(),
            MostLikedBlogScreen(),
            RecommendBlogScreen(),
          ],
        ),
      ),
    );
  }
}
