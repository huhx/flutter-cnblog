import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/home/category/home_blog_list_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';

import 'category/category/category_screen.dart';
import 'category/recommend/recommend_blog_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: TabBar(
                  tabs: [
                    Tab(text: "首页"),
                    Tab(text: "阅读榜"),
                    Tab(text: "推荐榜"),
                    Tab(text: "精华博客"),
                    Tab(text: "候选区"),
                    Tab(text: "编辑推荐"),
                  ],
                  indicatorColor: Colors.white,
                  isScrollable: true,
                  indicatorWeight: 1,
                ),
              ),
              InkWell(
                onTap: () => context.goto(const CategoryScreen()),
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
            HomeBlogListScreen(BlogCategory.home),
            HomeBlogListScreen(BlogCategory.read),
            HomeBlogListScreen(BlogCategory.like),
            HomeBlogListScreen(BlogCategory.essence),
            HomeBlogListScreen(BlogCategory.candidate),
            RecommendBlogScreen(),
          ],
        ),
      ),
    );
  }
}
