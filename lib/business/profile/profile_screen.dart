import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/business/user/login/login_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/theme/theme.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SessionModel sessionModel = ref.watch(sessionProvider.notifier);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: sessionModel.isAuth
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
        Container(
          color: themeColor,
          padding: const EdgeInsets.only(left: 16, top: 60, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => CommUtil.toBeDev(),
                child: Row(
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
                  children: [
                    InkWell(
                      onTap: () => CommUtil.toBeDev(),
                      child: Row(
                        children: const [
                          Text("185", style: TextStyle(color: Colors.white, fontSize: 16)),
                          SizedBox(width: 2),
                          Text("粉丝", style: TextStyle(fontSize: 12, color: Colors.white70)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => CommUtil.toBeDev(),
                      child: Row(
                        children: const [
                          Text("4", style: TextStyle(color: Colors.white, fontSize: 16)),
                          SizedBox(width: 2),
                          Text("关注", style: TextStyle(fontSize: 12, color: Colors.white70)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const ProfileMiddle(),
        Column(
          children: [
            ListTile(
              title: const Text("我的博客"),
              trailing: const IconTheme(data: IconThemeData(color: Colors.grey), child: Icon(Icons.keyboard_arrow_right)),
              onTap: () => CommUtil.toBeDev(),
            ),
            ListTile(
              title: const Text("我的订阅"),
              trailing: const IconTheme(data: IconThemeData(color: Colors.grey), child: Icon(Icons.keyboard_arrow_right)),
              onTap: () => CommUtil.toBeDev(),
            ),
            ListTile(
              title: const Text("我的收藏"),
              trailing: const IconTheme(data: IconThemeData(color: Colors.grey), child: Icon(Icons.keyboard_arrow_right)),
              onTap: () => CommUtil.toBeDev(),
            ),
            ListTile(
              title: const Text("关于"),
              trailing: const IconTheme(data: IconThemeData(color: Colors.grey), child: Icon(Icons.keyboard_arrow_right)),
              onTap: () => CommUtil.toBeDev(),
            ),
            ListTile(
              title: const Text("联系与反馈"),
              trailing: const IconTheme(data: IconThemeData(color: Colors.grey), child: Icon(Icons.keyboard_arrow_right)),
              onTap: () => CommUtil.toBeDev(),
            ),
            ListTile(
              title: const Text("设置"),
              trailing: const IconTheme(data: IconThemeData(color: Colors.grey), child: Icon(Icons.keyboard_arrow_right)),
              onTap: () => CommUtil.toBeDev(),
            ),
          ],
        )
      ],
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
              onTap: () => CommUtil.toBeDev(),
              child: const MomentMiddleItem(iconName: 'comment', label: '我的消息'),
            ),
            InkWell(
              onTap: () => CommUtil.toBeDev(),
              child: const MomentMiddleItem(iconName: 'main_blog', label: '阅读历史'),
            ),
            InkWell(
              onTap: () => CommUtil.toBeDev(),
              child: const MomentMiddleItem(iconName: 'main_question', label: '知识库'),
            ),
            InkWell(
              onTap: () => CommUtil.toBeDev(),
              child: const MomentMiddleItem(iconName: 'main_profile', label: '我的动态'),
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
