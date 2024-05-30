import 'package:app_common_flutter/extension.dart';
import 'package:app_common_flutter/util.dart';
import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_profile_api.dart';
import 'package:flutter_cnblog/business/instant/my_instant_screen.dart';
import 'package:flutter_cnblog/business/main/theme_provider.dart';
import 'package:flutter_cnblog/business/profile/blog/user_blog_list_screen.dart';
import 'package:flutter_cnblog/business/profile/bookmark/user_bookmark_list_screen.dart';
import 'package:flutter_cnblog/business/profile/follow/follow_screen.dart';
import 'package:flutter_cnblog/business/profile/setting/setting_screen.dart';
import 'package:flutter_cnblog/business/question/my/my_question_list_screen.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/business/user/login/login_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/model/follow.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/model/user_profile.dart';
import 'package:flutter_cnblog/theme/theme.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'knowledge/knowledge_list_screen.dart';
import 'official/official_blog_list_screen.dart';
import 'readlog/read_log_list_screen.dart';
import 'user_profile_detail_screen.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = useState(ref.read(themeProvider).themeMode == ThemeMode.dark);
    final User? user = ref.watch(sessionProvider);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDarkMode.value
              ? [const Color.fromRGBO(5, 5, 5, 1), const Color.fromRGBO(20, 20, 20, 1)]
              : [const Color.fromRGBO(250, 250, 250, 1), const Color.fromRGBO(235, 235, 235, 1)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                if (isDarkMode.value) {
                  isDarkMode.value = false;
                  ref.read(themeProvider).setDark(false);
                } else {
                  isDarkMode.value = true;
                  ref.read(themeProvider).setDark(true);
                }
              },
              icon: SvgIcon(name: isDarkMode.value ? "share_light_mode" : "share_dark_mode"),
            ),
            IconButton(
              onPressed: () => context.goto(const SettingScreen()),
              icon: const SvgIcon(name: "my_setting"),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            user != null ? ProfileHeader(user.toInfo()) : const NoLoginProfileHeader(),
            const SizedBox(height: 24),
            user != null ? ProfileInfo(user) : const NoLoginProfileInfo(),
            const SizedBox(height: 16),
            user != null ? ProfileMiddle(user.toInfo()) : const NoLoginProfileMiddle(),
            const SizedBox(height: 16),
            const ProfileFooter()
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final UserInfo user;

  const ProfileHeader(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.goto(UserProfileDetailScreen(user)),
      leading: CircleImage(url: user.avatar, size: 48),
      contentPadding: EdgeInsets.zero,
      title: Text(
        user.displayName,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
      ),
      trailing: const ListTileTrailing(),
    );
  }
}

class NoLoginProfileHeader extends StatelessWidget {
  const NoLoginProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.gotoLogin(const LoginScreen()),
      leading: const SvgIcon(name: "no_login_user", size: 48),
      contentPadding: EdgeInsets.zero,
      title: Text(
        "登录",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
      ),
      trailing: const ListTileTrailing(),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final User user;

  const ProfileInfo(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfileData>(
        future: userProfileApi.getUserProfileData(user.blogApp),
        builder: (context, snap) {
          if (!snap.hasData) return const NoLoginProfileInfo();
          final UserProfileData userProfileData = snap.data as UserProfileData;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: ProfileInfoItem(counts: userProfileData.follow, label: "关注"),
                onTap: () => context.goto(FollowScreen(
                  name: userProfileData.name,
                  followType: FollowType.follow,
                )),
              ),
              InkWell(
                child: ProfileInfoItem(counts: userProfileData.follower, label: "粉丝"),
                onTap: () => context.goto(FollowScreen(
                  name: userProfileData.name,
                  followType: FollowType.follower,
                )),
              ),
              ProfileInfoItem(counts: userProfileData.comment, label: "评论"),
              ProfileInfoItem(counts: userProfileData.view, label: "阅读"),
            ],
          );
        });
  }
}

class NoLoginProfileInfo extends StatelessWidget {
  const NoLoginProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          child: const ProfileInfoItem(counts: 0, label: "关注"),
          onTap: () => context.gotoLogin(const LoginScreen()),
        ),
        InkWell(
          child: const ProfileInfoItem(counts: 0, label: "粉丝"),
          onTap: () => context.gotoLogin(const LoginScreen()),
        ),
        const ProfileInfoItem(counts: 0, label: "评论"),
        const ProfileInfoItem(counts: 0, label: "阅读"),
      ],
    );
  }
}

class ProfileInfoItem extends StatelessWidget {
  final int counts;
  final String label;

  const ProfileInfoItem({super.key, required this.counts, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          counts.toString(),
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }
}

class ProfileMiddle extends StatelessWidget {
  final UserInfo userInfo;

  const ProfileMiddle(this.userInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () => context.goto(UserBlogListScreen(userInfo)),
            child: const MomentMiddleItem(iconName: 'profile_blog', label: '我的博客'),
          ),
          InkWell(
            onTap: () => context.goto(const MyQuestionListScreen()),
            child: const MomentMiddleItem(iconName: 'profile_question', label: '我的博问'),
          ),
          InkWell(
            onTap: () => context.goto(const MyInstantScreen()),
            child: const MomentMiddleItem(iconName: 'my_message', label: '我的闪存'),
          ),
          InkWell(
            onTap: () => context.goto(UserBookmarkListScreen(userInfo)),
            child: const MomentMiddleItem(iconName: 'profile_bookmark', label: '我的收藏'),
          ),
        ],
      ),
    );
  }
}

class NoLoginProfileMiddle extends StatelessWidget {
  const NoLoginProfileMiddle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () => context.gotoLogin(const LoginScreen()),
            child: const MomentMiddleItem(iconName: 'profile_blog', label: '我的博客'),
          ),
          InkWell(
            onTap: () => context.gotoLogin(const LoginScreen()),
            child: const MomentMiddleItem(iconName: 'profile_question', label: '我的博问'),
          ),
          InkWell(
            onTap: () => context.gotoLogin(const LoginScreen()),
            child: const MomentMiddleItem(iconName: 'my_message', label: '我的闪存'),
          ),
          InkWell(
            onTap: () => context.gotoLogin(const LoginScreen()),
            child: const MomentMiddleItem(iconName: 'profile_bookmark', label: '我的收藏'),
          ),
        ],
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
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SvgIcon(name: iconName, color: themeColor),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}

class ProfileFooter extends StatelessWidget {
  const ProfileFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("更多功能"),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  context.showCommDialog(
                    title: "提交意见反馈",
                    content: "如果在使用过程中遇到问题,请联系QQ: 285490389.点击确定即复制",
                    callback: () async {
                      await CommUtil.copyText("285490389");
                      context.showSnackBar('QQ已复制');
                    },
                  );
                },
                child: const MomentMiddleItem(iconName: 'profile_feedback', label: '意见反馈'),
              ),
              InkWell(
                onTap: () => context.goto(const OfficialBlogListScreen()),
                child: const MomentMiddleItem(iconName: 'profile_official', label: '官方博客'),
              ),
              InkWell(
                onTap: () => context.goto(const ReadLogListScreen()),
                child: const MomentMiddleItem(iconName: 'my_history', label: '阅读记录'),
              ),
              InkWell(
                onTap: () => context.goto(const KnowledgeListScreen()),
                child: const MomentMiddleItem(iconName: 'my_knowledge', label: '知识库'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
