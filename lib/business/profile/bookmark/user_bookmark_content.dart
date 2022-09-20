import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/read_log_api.dart';
import 'package:flutter_cnblog/api/user_bookmark_api.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/empty_widget.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/bookmark.dart';
import 'package:flutter_cnblog/model/detail_model.dart';
import 'package:flutter_cnblog/model/read_log.dart';
import 'package:flutter_cnblog/model/user.dart';
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
  final StreamList<BookmarkInfo> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<BookmarkInfo> bookmarks = await userBookmarkApi.getUserBookmarkList(pageKey);
      streamList.fetch(bookmarks, pageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamList.stream,
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final List<BookmarkInfo> bookmarks = snap.data as List<BookmarkInfo>;

        if (bookmarks.isEmpty) {
          return const EmptyWidget();
        }

        return SmartRefresher(
          controller: streamList.refreshController,
          onRefresh: () => streamList.onRefresh(),
          onLoading: () => streamList.onLoading(),
          enablePullUp: true,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            itemCount: bookmarks.length,
            itemBuilder: (_, index) => UserBookmarkItem(bookmark: bookmarks[index], key: ValueKey(bookmarks[index].id)),
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

class UserBookmarkItem extends StatelessWidget {
  final BookmarkInfo bookmark;

  const UserBookmarkItem({Key? key, required this.bookmark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goto(UserBookmarkDetailScreen(bookmark));
        final DetailModel detailModel = bookmark.toDetail();
        readLogApi.insert(ReadLog.of(type: bookmark.getReadLogType(), summary: bookmark.url, detailModel: detailModel));
      },
      child: Card(
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
                  const SvgIcon(name: "star", size: 14, color: Colors.grey),
                  const SizedBox(width: 2),
                  Text("${bookmark.starCounts}", style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  const Text("人收藏", style: TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
