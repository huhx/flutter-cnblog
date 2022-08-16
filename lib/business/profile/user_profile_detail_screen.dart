import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_profile_api.dart';
import 'package:flutter_cnblog/business/profile/blog/user_blog_list_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/model/user_profile.dart';
import 'package:flutter_cnblog/theme/theme.dart';
import 'package:flutter_cnblog/util/comm_util.dart';

class UserProfileDetailScreen extends StatelessWidget {
  final User user;

  const UserProfileDetailScreen(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserProfileHeader(user),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: const TabBar(
                    tabs: [Tab(text: "资料"), Tab(text: "动态")],
                    indicatorColor: Colors.white,
                    isScrollable: true,
                    indicatorWeight: 1,
                  ),
                ),
                body: TabBarView(
                  children: [UserInfo(user), UserMoment(user)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileHeader extends StatelessWidget {
  final User user;

  const UserProfileHeader(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: themeColor,
          padding: const EdgeInsets.only(left: 16, top: 60, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleImage(url: user.avatar, size: 48),
                  const SizedBox(width: 8),
                  Text(user.displayName, style: const TextStyle(color: Colors.white, fontSize: 20)),
                ],
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
        const Positioned(
          top: 40,
          child: AppbarBackButton(),
        )
      ],
    );
  }
}

class UserInfo extends StatelessWidget {
  final User user;

  const UserInfo(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfileInfo>(
      future: userProfileApi.getUserProfile(user.displayName),
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final UserProfileInfo userProfile = snap.data as UserProfileInfo;
        List<Widget> widgets = [];
        userProfile.info.forEach((key, value) {
          final listTile = ListTile(leading: Text(key), trailing: Text(value));
          widgets.add(listTile);
        });
        return ListView(
          shrinkWrap: true,
          primary: false,
          children: [
            ListTile(
              leading: const Text("我的博客"),
              trailing: const IconTheme(data: IconThemeData(color: Colors.grey), child: Icon(Icons.keyboard_arrow_right)),
              onTap: () => context.goto(UserBlogListScreen(user)),
            ),
            ...widgets
          ],
        );
      },
    );
  }
}

class UserMoment extends StatelessWidget {
  final User user;

  const UserMoment(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Hello"),
    );
  }
}
