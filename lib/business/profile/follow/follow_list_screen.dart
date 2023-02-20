import 'package:app_common_flutter/pagination.dart';
import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_follow_api.dart';
import 'package:flutter_cnblog/business/profile/user_profile_detail_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/model/follow.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FollowListScreen extends StatefulHookWidget {
  final String name;
  final FollowType type;

  const FollowListScreen(this.name, this.type, {super.key});

  @override
  State<FollowListScreen> createState() => _FollowListScreenState();
}

class _FollowListScreenState extends StreamState<FollowListScreen, FollowInfo> {
  @override
  Future<void> fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<FollowInfo> followList = await userFollowApi.getUserFollowList(widget.name, widget.type, pageKey);
      streamList.fetch(followList, pageKey, pageSize: 45);
    }
  }

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: true);

    return PagedView(
      streamList,
      (context, followList) => ListView.builder(
        itemCount: followList.length,
        itemBuilder: (_, index) => FollowItem(followList[index], key: ValueKey(followList[index].userId)),
      ),
    );
  }
}

class FollowItem extends StatelessWidget {
  final FollowInfo followInfo;

  const FollowItem(this.followInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goto(UserProfileDetailScreen(followInfo.toUserInfo())),
      child: Card(
        child: ListTile(
          leading: CircleImage(url: followInfo.avatar, size: 48),
          title: Text(followInfo.name, style: Theme.of(context).textTheme.bodyMedium),
          subtitle: Text(followInfo.displayName, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          trailing: const ListTileTrailing(),
        ),
      ),
    );
  }
}
