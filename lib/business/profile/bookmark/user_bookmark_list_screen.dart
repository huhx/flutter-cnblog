import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/theme/theme.dart';
import 'package:flutter_cnblog/util/comm_util.dart';

import 'user_bookmark_content.dart';

class UserBookmarkListScreen extends StatefulWidget {
  final User user;

  const UserBookmarkListScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<UserBookmarkListScreen> createState() => _UserBookmarkListScreenState();
}

class _UserBookmarkListScreenState extends State<UserBookmarkListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserBookmarkHeader(widget.user),
          const Divider(thickness: 8, color: momentBgColor),
          Expanded(child: UserBookmarkContent(widget.user)),
        ],
      ),
    );
  }
}

class UserBookmarkHeader extends StatelessWidget {
  final User user;

  const UserBookmarkHeader(this.user, {Key? key}) : super(key: key);

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => CommUtil.toBeDev(),
                      child: Row(
                        children: const [
                          Text("267", style: TextStyle(color: Colors.white, fontSize: 16)),
                          SizedBox(width: 2),
                          Text("随笔", style: TextStyle(fontSize: 12, color: Colors.white70)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: const [
                        Text("11", style: TextStyle(color: Colors.white, fontSize: 16)),
                        SizedBox(width: 2),
                        Text("文章", style: TextStyle(fontSize: 12, color: Colors.white70)),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: const [
                        Text("138", style: TextStyle(color: Colors.white, fontSize: 16)),
                        SizedBox(width: 2),
                        Text("评论", style: TextStyle(fontSize: 12, color: Colors.white70)),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: const [
                        Text("67万", style: TextStyle(color: Colors.white, fontSize: 16)),
                        SizedBox(width: 2),
                        Text("阅读", style: TextStyle(fontSize: 12, color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
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
