import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_follow_api.dart';
import 'package:flutter_cnblog/business/profile/user_profile_detail_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/component/list_tile_trailing.dart';
import 'package:flutter_cnblog/model/follow.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FollowListScreen extends StatefulWidget {
  final String name;
  final FollowType type;

  const FollowListScreen(this.name, this.type, {Key? key}) : super(key: key);

  @override
  State<FollowListScreen> createState() => _FollowListScreenState();
}

class _FollowListScreenState extends State<FollowListScreen> {
  final StreamList<FollowInfo> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<FollowInfo> followList = await userFollowApi.getUserFollowList(widget.name, widget.type, pageKey);
      streamList.fetch(followList, pageKey, pageSize: 45);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamList.stream,
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final List<FollowInfo> followList = snap.data as List<FollowInfo>;

        return SmartRefresher(
          controller: streamList.refreshController,
          onRefresh: () => streamList.onRefresh(),
          onLoading: () => streamList.onLoading(),
          enablePullUp: true,
          child: ListView.builder(
            itemCount: followList.length,
            itemBuilder: (_, index) => FollowItem(followList[index], key: ValueKey(followList[index].userId)),
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
}

class FollowItem extends StatelessWidget {
  final FollowInfo followInfo;

  const FollowItem(this.followInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: InkWell(
        onTap: () => context.goto(UserProfileDetailScreen(followInfo.toUserInfo())),
        child: Card(
          child: ListTile(
            leading: CircleImage(url: followInfo.avatar, size: 48),
            title: Text(followInfo.name),
            subtitle: Text(followInfo.displayName, style: const TextStyle(fontSize: 13, color: Colors.grey)),
            trailing: const ListTileTrailing(),
          ),
        ),
      ),
    );
  }
}
