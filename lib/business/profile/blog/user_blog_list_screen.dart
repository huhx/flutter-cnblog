import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/profile/user_blog_data_info.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/theme/theme.dart';
import 'package:flutter_cnblog/util/comm_util.dart';

import 'user_blog_content.dart';

class UserBlogListScreen extends StatefulWidget {
  final UserInfo user;

  const UserBlogListScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<UserBlogListScreen> createState() => _UserBlogListScreenState();
}

class _UserBlogListScreenState extends State<UserBlogListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserBlogHeader(widget.user),
          const Divider(thickness: 8, color: momentBgColor),
          Expanded(child: UserBlogContent(widget.user)),
        ],
      ),
    );
  }
}

class UserBlogHeader extends StatelessWidget {
  final UserInfo user;

  const UserBlogHeader(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          color: themeColor,
          padding: const EdgeInsets.only(left: 16, top: 60, bottom: 20),
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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: UserBlogDataInfo(user),
              ),
            ],
          ),
        ),
        const Positioned(
          top: 40,
          child: AppbarBackButton(),
        )
      ],
    );
  }
}
