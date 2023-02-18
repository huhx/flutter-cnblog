import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/profile/user_blog_data_info.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/model/user.dart';

import 'user_blog_content.dart';

class UserBlogListScreen extends StatefulWidget {
  final UserInfo user;

  const UserBlogListScreen(this.user, {super.key});

  @override
  State<UserBlogListScreen> createState() => _UserBlogListScreenState();
}

class _UserBlogListScreenState extends State<UserBlogListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          leading: const AppbarBackButton(),
          flexibleSpace: UserBlogHeader(widget.user),
        ),
      ),
      body: UserBlogContent(widget.user),
    );
  }
}

class UserBlogHeader extends StatelessWidget {
  final UserInfo user;

  const UserBlogHeader(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 60, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleImage(url: user.avatar, size: 48),
              const SizedBox(width: 8),
              Text(user.displayName, style: const TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
          Padding(padding: const EdgeInsets.only(top: 26), child: UserBlogDataInfo(user)),
        ],
      ),
    );
  }
}
