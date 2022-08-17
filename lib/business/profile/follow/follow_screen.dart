import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/model/follow.dart';

import 'follow_list_screen.dart';

class FollowScreen extends StatelessWidget {
  final String name;
  final int index;

  const FollowScreen({required this.name, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: index,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppbarBackButton(),
          title: const TabBar(
            tabs: [
              Tab(text: "我的关注"),
              Tab(text: "我的粉丝"),
            ],
            indicatorColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 1,
          ),
        ),
        body: TabBarView(
          children: [
            FollowListScreen(name, FollowType.follow),
            FollowListScreen(name, FollowType.follower),
          ],
        ),
      ),
    );
  }
}
