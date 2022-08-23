import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_bookmark_api.dart';
import 'package:flutter_cnblog/common/extension/comm_extension.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/custom_paged_builder_delegate.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/bookmark.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'user_bookmark_detail_screen.dart';

class UserBookmarkContent extends StatefulWidget {
  final UserInfo user;

  const UserBookmarkContent(this.user, {Key? key}) : super(key: key);

  @override
  State<UserBookmarkContent> createState() => _UserBookmarkContentState();
}

class _UserBookmarkContentState extends State<UserBookmarkContent> {
  final PagingController<int, BookmarkInfo> _pagingController = PagingController(firstPageKey: 1);
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    final List<BookmarkInfo> bookmarks = await userBookmarkApi.getUserBookmarkList(pageKey);
    _pagingController.fetch(bookmarks, pageKey);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: _onRefresh,
      child: PagedListView<int, BookmarkInfo>(
        pagingController: _pagingController,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        builderDelegate: PagedChildBuilderDelegate<BookmarkInfo>(
          firstPageProgressIndicatorBuilder: (_) => const FirstPageProgressIndicator(),
          newPageProgressIndicatorBuilder: (_) => const NewPageProgressIndicator(),
          noMoreItemsIndicatorBuilder: (_) => const NoMoreItemsIndicator(),
          itemBuilder: (context, item, index) => UserBookmarkItem(bookmark: item),
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

class UserBookmarkItem extends StatelessWidget {
  final BookmarkInfo bookmark;

  const UserBookmarkItem({Key? key, required this.bookmark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goto(UserBookmarkDetailScreen(bookmark)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(bookmark.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            const SizedBox(height: 6),
            Text(bookmark.url, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 6),
            Row(
              children: [
                const Text("收藏于", style: TextStyle(fontSize: 13, color: Colors.grey)),
                Text(
                  timeago.format(bookmark.postDate),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(width: 16),
                const SvgIcon(name: "like", size: 14, color: Colors.grey),
                const SizedBox(width: 6),
                Text("${bookmark.starCounts}", style: const TextStyle(fontSize: 13, color: Colors.grey)),
                const Text("人收藏", style: TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
