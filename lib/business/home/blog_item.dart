import 'package:flutter/material.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'blog_detail_screen.dart';

class BlogItem extends StatelessWidget {
  final BlogResp blog;

  const BlogItem({required this.blog, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goto(BlogDetailScreen(blog: blog)),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(blog.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              const SizedBox(height: 6),
              Text(
                blog.description,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
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
                      CircleImage(url: blog.avatar),
                      const SizedBox(width: 6),
                      Text(blog.author, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(width: 16),
                      TextIcon(icon: "like", counts: blog.diggCount),
                      const SizedBox(width: 8),
                      TextIcon(icon: "comment", counts: blog.commentCount),
                      const SizedBox(width: 8),
                      TextIcon(icon: "view", counts: blog.viewCount),
                    ],
                  ),
                  Text(
                    timeago.format(blog.postDate),
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
