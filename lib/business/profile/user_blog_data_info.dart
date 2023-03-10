import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_blog_data_api.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/model/user_blog.dart';

class UserBlogDataInfo extends StatelessWidget {
  final UserInfo user;

  const UserBlogDataInfo(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BlogDataInfo>(
      future: userBlogDataApi.getBlogDataInfo(user.blogName),
      builder: (context, snap) {
        if (!snap.hasData) return const SizedBox();
        final BlogDataInfo blogData = snap.data as BlogDataInfo;

        return Wrap(
          spacing: 16,
          children: [
            BlogInfoItem(label: "随笔", count: blogData.blogCount),
            BlogInfoItem(label: "文章", count: blogData.articleCount),
            BlogInfoItem(label: "评论", count: blogData.commentCount),
            BlogInfoItem(label: "阅读", count: blogData.viewCount),
          ],
        );
      },
    );
  }
}

class BlogInfoItem extends StatelessWidget {
  final String label;
  final int count;

  const BlogInfoItem({
    super.key,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$count",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }
}
