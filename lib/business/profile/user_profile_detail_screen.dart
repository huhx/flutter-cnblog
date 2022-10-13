import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_profile_api.dart';
import 'package:flutter_cnblog/business/profile/blog/user_blog_list_screen.dart';
import 'package:flutter_cnblog/common/current_user.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/component/empty_widget.dart';
import 'package:flutter_cnblog/component/list_tile_trailing.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/model/user_profile.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'user_follow_count_info.dart';

class UserProfileDetailScreen extends StatelessWidget {
  final UserInfo user;

  const UserProfileDetailScreen(this.user, {Key? key}) : super(key: key);

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

  const UserProfileHeader(this.user, {Key? key}) : super(key: key);

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
              Text(user.displayName, style: const TextStyle(color: Colors.white, fontSize: 20)),
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

class UserHeaderInfo extends StatefulWidget {
  final UserInfo user;

  const UserHeaderInfo(this.user, {Key? key}) : super(key: key);

  @override
  State<UserHeaderInfo> createState() => _UserHeaderInfoState();
}

class _UserHeaderInfoState extends State<UserHeaderInfo> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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

  @override
  bool get wantKeepAlive => true;
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
          ConstrainedBox(constraints: const BoxConstraints(minWidth: 40), child: left),
          right,
        ],
      ),
    );
  }
}

class UserMoment extends StatefulWidget {
  final UserInfo user;

  const UserMoment(this.user, {Key? key}) : super(key: key);

  @override
  State<UserMoment> createState() => _UserMomentState();
}

class _UserMomentState extends State<UserMoment> with AutomaticKeepAliveClientMixin {
  final StreamList<UserProfileMoment> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    final List<UserProfileMoment> userMoments = await userProfileApi.getUserProfileMoment(widget.user.blogName, pageKey);
    streamList.fetch(userMoments, pageKey, pageSize: 30);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: streamList.stream,
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final List<UserProfileMoment> userMoments = snap.data as List<UserProfileMoment>;

        if (userMoments.isEmpty) {
          return const EmptyWidget();
        }

        return SmartRefresher(
          controller: streamList.refreshController,
          onRefresh: () => streamList.onRefresh(),
          onLoading: () => streamList.onLoading(),
          enablePullUp: true,
          child: ListView.builder(
            itemCount: userMoments.length,
            itemBuilder: (_, index) => UserMomentItem(userMoments[index], key: ValueKey(userMoments[index].url)),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    streamList.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class UserMomentItem extends StatelessWidget {
  final UserProfileMoment userMoment;

  const UserMomentItem(this.userMoment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                  Text(userMoment.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
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
