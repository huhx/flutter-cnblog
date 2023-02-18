import 'package:app_common_flutter/pagination.dart';
import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/read_log_api.dart';
import 'package:flutter_cnblog/api/user_bookmark_api.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/model/bookmark.dart';
import 'package:flutter_cnblog/model/detail_model.dart';
import 'package:flutter_cnblog/model/read_log.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'user_bookmark_detail_screen.dart';

class UserBookmarkContent extends StatefulWidget {
  final UserInfo user;

  const UserBookmarkContent(this.user, {super.key});

  @override
  State<UserBookmarkContent> createState() => _UserBookmarkContentState();
}

class _UserBookmarkContentState extends StreamState<UserBookmarkContent, BookmarkInfo> {
  @override
  Future<void> fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<BookmarkInfo> bookmarks = await userBookmarkApi.getUserBookmarkList(pageKey);
      streamList.fetch(bookmarks, pageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedView(
      streamList,
      (context, bookmarks) => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        itemCount: bookmarks.length,
        itemBuilder: (_, index) => UserBookmarkItem(bookmark: bookmarks[index], key: ValueKey(bookmarks[index].id)),
      ),
    );
  }
}

class UserBookmarkItem extends StatelessWidget {
  final BookmarkInfo bookmark;

  const UserBookmarkItem({super.key, required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goto(UserBookmarkDetailScreen(bookmark));
        final DetailModel detailModel = bookmark.toDetail();
        readLogApi.insert(ReadLog.of(type: bookmark.readLogType, summary: bookmark.url, detailModel: detailModel));
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
