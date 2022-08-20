import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_cnblog/util/comm_util.dart';

import 'my_search_list_screen.dart';

class MySearchScreen extends StatefulWidget {
  const MySearchScreen({Key? key}) : super(key: key);

  @override
  State<MySearchScreen> createState() => _MySearchScreenState();
}

class _MySearchScreenState extends State<MySearchScreen> {
  String query = "android";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppbarBackButton(),
          title: const Text("MySearch"),
          actions: [
            TextButton(onPressed: () => CommUtil.toBeDev(), child: const Text("搜索")),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "博客"),
              Tab(text: "博问"),
              Tab(text: "闪存"),
            ],
            indicatorColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 1,
          ),
        ),
        body: TabBarView(
          children: [
            MySearchListScreen(MySearchType.blog, query),
            MySearchListScreen(MySearchType.question, query),
            MySearchListScreen(MySearchType.instant, query),
          ],
        ),
      ),
    );
  }
}
