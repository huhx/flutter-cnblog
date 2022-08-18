import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_follow_api.dart';
import 'package:flutter_cnblog/common/extension/comm_extension.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/component/custom_paged_builder_delegate.dart';
import 'package:flutter_cnblog/model/follow.dart';
import 'package:flutter_cnblog/theme/theme.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FollowListScreen extends StatefulWidget {
  final String name;
  final FollowType type;

  const FollowListScreen(this.name, this.type, {Key? key}) : super(key: key);

  @override
  State<FollowListScreen> createState() => _FollowListScreenState();
}

class _FollowListScreenState extends State<FollowListScreen> {
  static const int pageSize = 45;
  final PagingController<int, FollowInfo> _pagingController = PagingController(firstPageKey: 1);
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    final List<FollowInfo> blogs = await userFollowApi.getUserFollowList(widget.type, pageKey);
    _pagingController.fetch(blogs, pageKey, pageSize: pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: _onRefresh,
      child: PagedListView<int, FollowInfo>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<FollowInfo>(
          firstPageProgressIndicatorBuilder: (_) => const FirstPageProgressIndicator(),
          newPageProgressIndicatorBuilder: (_) => const NewPageProgressIndicator(),
          noMoreItemsIndicatorBuilder: (_) => const NoMoreItemsIndicator(),
          itemBuilder: (context, item, index) => FollowItem(item),
        ),
      ),
    );
  }

  void _onRefresh() {
    _pagingController.refresh();
    refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _pagingController.dispose();
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
      child: Card(
        child: ListTile(
          leading: CircleImage(url: followInfo.avatar, size: 48),
          title: Text(followInfo.name),
          subtitle: Text(followInfo.displayName, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 0),
              primary: themeColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              textStyle: const TextStyle(color: Colors.white, fontSize: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            ),
            onPressed: () => CommUtil.toBeDev(),
            child: const Text("取消关注"),
          ),
        ),
      ),
    );
  }
}
