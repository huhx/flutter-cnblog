import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/profile/blog/user_blog_list_screen.dart';
import 'package:flutter_cnblog/business/profile/bookmark/user_bookmark_list_screen.dart';
import 'package:flutter_cnblog/business/search/my/my_search_screen.dart';
import 'package:flutter_cnblog/business/search/search_screen.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/business/user/login/login_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/component/list_tile_trailing.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/theme/theme.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'knowledge/knowledge_list_screen.dart';
import 'message/message_screen.dart';
import 'user_follow_count_info.dart';
import 'user_profile_detail_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(sessionProvider);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: user != null
            ? MyProfileScreen(AppConfig.get("user"))
            : InkWell(
                child: TextButton(
                  onPressed: () => context.goto(const LoginScreen()),
                  child: const Text("去登录"),
                ),
              ),
      ),
    );
  }
}

class MyProfileScreen extends StatelessWidget {
  final User user;

  const MyProfileScreen(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileHeader(user),
        const ProfileMiddle(),
        ProfileFooter(user),
      ],
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final User user;

  const ProfileHeader(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeColor,
      padding: const EdgeInsets.only(left: 16, top: 60, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => context.goto(UserProfileDetailScreen(user)),
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
            child: UserFollowCountInfo(user),
          ),
        ],
      ),
    );
  }
}

class ProfileMiddle extends StatelessWidget {
  const ProfileMiddle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () => context.goto(const MessageScreen()),
              child: const MomentMiddleItem(iconName: 'my_message', label: '我的消息'),
            ),
            InkWell(
              onTap: () => CommUtil.toBeDev(),
              child: const MomentMiddleItem(iconName: 'my_history', label: '阅读历史'),
            ),
            InkWell(
              onTap: () => context.goto(const KnowledgeListScreen()),
              child: const MomentMiddleItem(iconName: 'my_knowledge', label: '知识库'),
            ),
            InkWell(
              onTap: () => CommUtil.toBeDev(),
              child: const MomentMiddleItem(iconName: 'my_moment', label: '我的动态'),
            ),
          ],
        ),
      ),
    );
  }
}

class MomentMiddleItem extends StatelessWidget {
  final String iconName;
  final String label;

  const MomentMiddleItem({
    super.key,
    required this.iconName,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgIcon(name: iconName, color: themeColor),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}

class ProfileFooter extends StatelessWidget {
  final User user;

  const ProfileFooter(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text("我的博客"),
          trailing: const ListTileTrailing(),
          onTap: () => context.goto(UserBlogListScreen(user)),
        ),
        ListTile(
          title: const Text("我的收藏"),
          trailing: const ListTileTrailing(),
          onTap: () => context.goto(UserBookmarkListScreen(user)),
        ),
        ListTile(
          title: const Text("关于"),
          trailing: const ListTileTrailing(),
          onTap: () => context.goto(const SearchScreen()),
        ),
        ListTile(
          title: const Text("联系与反馈"),
          trailing: const ListTileTrailing(),
          onTap: () => context.goto(const MySearchScreen()),
        ),
        ListTile(
          title: const Text("设置"),
          trailing: const ListTileTrailing(),
          onTap: () => CommUtil.toBeDev(),
        ),
      ],
    );
  }
}
