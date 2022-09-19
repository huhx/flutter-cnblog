import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/read_log_api.dart';
import 'package:flutter_cnblog/business/home/blog_detail_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/detail_model.dart';
import 'package:flutter_cnblog/model/read_log.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserBlogItem extends StatelessWidget {
  final UserBlog userBlog;
  final UserInfo userInfo;

  const UserBlogItem({super.key, required this.userBlog, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DetailModel detailModel = userBlog.toDetail(userInfo.avatar);
        await readLogApi.insert(ReadLog.of(type: ReadLogType.blog, summary: userBlog.summary, detailModel: detailModel));
        context.goto(BlogDetailScreen(blog: detailModel));
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userBlog.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              const SizedBox(height: 6),
              Text(
                userBlog.summary,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(userBlog.name, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(width: 16),
                      TextIcon(icon: "like", counts: userBlog.diggCount),
                      const SizedBox(width: 8),
                      TextIcon(icon: "comment", counts: userBlog.commentCount),
                      const SizedBox(width: 8),
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
      ),
    );
  }
}
