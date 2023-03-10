import 'package:app_common_flutter/pagination.dart';
import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_profile_api.dart';
import 'package:flutter_cnblog/business/profile/blog/user_blog_list_screen.dart';
import 'package:flutter_cnblog/common/current_user.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/model/user_profile.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'user_follow_count_info.dart';

class UserProfileDetailScreen extends StatelessWidget {
  final UserInfo user;

  const UserProfileDetailScreen(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(170),
          child: AppBar(
            leading: const AppbarBackButton(),
            flexibleSpace: UserProfileHeader(user),
            bottom: const TabBar(
              tabs: [Tab(text: "资料"), Tab(text: "动态")],
              indicatorColor: Colors.white,
              isScrollable: true,
              indicatorWeight: 1,
            ),
          ),
        ),
        body: TabBarView(
          children: [UserHeaderInfo(user), UserMoment(user)],
        ),
      ),
    );
  }
}

class UserProfileHeader extends StatelessWidget {
  final UserInfo user;

  const UserProfileHeader(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleImage(url: user.avatar, size: 48),
              const SizedBox(width: 8),
              Text(
                user.displayName,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: UserFollowCountInfo(user),
          ),
        ],
      ),
    );
  }
}

class UserHeaderInfo extends StatefulHookWidget {
  final UserInfo user;

  const UserHeaderInfo(this.user, {super.key});

  @override
  State<UserHeaderInfo> createState() => _UserHeaderInfoState();
}

class _UserHeaderInfoState extends State<UserHeaderInfo> {
  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: true);

    return FutureBuilder<UserProfileInfo>(
      future: userProfileApi.getUserProfile(widget.user.blogName),
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final UserProfileInfo userProfile = snap.data as UserProfileInfo;
        final String string = CurrentUser.getUser().displayName == userProfile.name ? "我" : "Ta";
        List<Widget> widgets = [];
        userProfile.info.forEach((key, value) {
          final listTile = UserHeaderInfoItem(
            left: Text(key),
            right: Text(value, overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.end),
          );
          widgets.add(listTile);
        });
        final bool hasBlog = userProfile.info.keys.contains("博客");
        return ListView(
          shrinkWrap: true,
          primary: false,
          children: [
            if (hasBlog)
              InkWell(
                onTap: () => context.goto(UserBlogListScreen(widget.user)),
                child: UserHeaderInfoItem(left: Text("$string的博客"), right: const ListTileTrailing()),
              ),
            ...widgets
          ],
        );
      },
    );
  }
}

class UserHeaderInfoItem extends StatelessWidget {
  final Widget left;
  final Widget right;

  const UserHeaderInfoItem({super.key, required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 40),
            child: left,
          ),
          right,
        ],
      ),
    );
  }
}

class UserMoment extends StatefulHookWidget {
  final UserInfo user;

  const UserMoment(this.user, {super.key});

  @override
  State<UserMoment> createState() => _UserMomentState();
}

class _UserMomentState extends StreamState<UserMoment, UserProfileMoment> {
  @override
  Future<void> fetchPage(int pageKey) async {
    final List<UserProfileMoment> userMoments = await userProfileApi.getUserProfileMoment(widget.user.blogName, pageKey);
    streamList.fetch(userMoments, pageKey, pageSize: 30);
  }

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: true);

    return PagedView(
      streamList,
      (context, userMoments) => ListView.builder(
        itemCount: userMoments.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (_, index) => UserMomentItem(
          userMoments[index],
          key: ValueKey(userMoments[index].url),
        ),
      ),
    );
  }
}

class UserMomentItem extends StatelessWidget {
  final UserProfileMoment userMoment;

  const UserMomentItem(this.userMoment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleImage(url: userMoment.avatar, size: 36),
              const SizedBox(width: 16),
              Text(
                userMoment.postDate,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(width: 6),
              Text(
                userMoment.action,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Card(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userMoment.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userMoment.summary,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
