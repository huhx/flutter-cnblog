import 'package:flutter/material.dart';
import 'package:flutter_cnblog/common/current_user.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/model/follow.dart';

import 'follow_list_screen.dart';

class FollowScreen extends StatelessWidget {
  final String name;
  final FollowType followType;

  const FollowScreen({required this.name, required this.followType, super.key});

  @override
  Widget build(BuildContext context) {
    final String string = CurrentUser.getUser().displayName == name ? "我" : "Ta";
    return DefaultTabController(
      length: 2,
      initialIndex: followType.tabIndex,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppbarBackButton(),
          title: TabBar(
            tabs: [
              Tab(text: "$string的关注"),
              Tab(text: "$string的粉丝"),
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
