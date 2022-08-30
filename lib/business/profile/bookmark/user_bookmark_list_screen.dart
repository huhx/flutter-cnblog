import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/profile/user_blog_data_info.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/util/comm_util.dart';

import 'user_bookmark_content.dart';

class UserBookmarkListScreen extends StatelessWidget {
  final UserInfo user;

  const UserBookmarkListScreen(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          leading: const AppbarBackButton(),
          flexibleSpace: UserBookmarkHeader(user),
        ),
      ),
      body: UserBookmarkContent(user),
    );
  }
}

class UserBookmarkHeader extends StatelessWidget {
  final UserInfo user;

  const UserBookmarkHeader(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 60, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => CommUtil.toBeDev(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleImage(url: user.avatar, size: 48),
                const SizedBox(width: 8),
                Text(user.displayName, style: const TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.only(top: 20), child: UserBlogDataInfo(user)),
        ],
      ),
    );
  }
}
