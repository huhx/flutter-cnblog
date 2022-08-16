import 'package:flutter/material.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'user_blog_detail_screen.dart';

class UserBlogItem extends StatelessWidget {
  final UserBlog userBlog;

  const UserBlogItem({Key? key, required this.userBlog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goto(UserBlogDetailScreen(userBlog)),
      child: Container(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Html(data: userBlog.title),
            const SizedBox(height: 6),
            Text(
              userBlog.summary,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(userBlog.name, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(width: 8),
                    TextIcon(icon: "like", counts: userBlog.diggCount),
                    const SizedBox(width: 8),
                    TextIcon(icon: "comment", counts: userBlog.commentCount),
                    const SizedBox(width: 10),
                    TextIcon(icon: "view", counts: userBlog.viewCount),
                  ],
                ),
                Text(
                  timeago.format(userBlog.postDate),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
