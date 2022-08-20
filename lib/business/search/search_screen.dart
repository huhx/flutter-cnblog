import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_cnblog/util/comm_util.dart';

import 'search_list_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "android";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppbarBackButton(),
          title: const Text("Search"),
          actions: [
            TextButton(onPressed: () => CommUtil.toBeDev(), child: const Text("搜索")),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "博客"),
              Tab(text: "新闻"),
              Tab(text: "博问"),
              Tab(text: "知识库"),
            ],
            indicatorColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 1,
          ),
        ),
        body: TabBarView(
          children: [
            SearchListScreen(SearchType.blog, query),
            SearchListScreen(SearchType.news, query),
            SearchListScreen(SearchType.question, query),
            SearchListScreen(SearchType.knowledge, query),
          ],
        ),
      ),
    );
  }
}
