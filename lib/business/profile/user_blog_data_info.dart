import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_blog_data_api.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:flutter_cnblog/util/comm_util.dart';

class UserBlogDataInfo extends StatelessWidget {
  final UserInfo user;

  const UserBlogDataInfo(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BlogDataInfo>(
      future: userBlogDataApi.getBlogDataInfo(user.displayName),
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final BlogDataInfo blogData = snap.data as BlogDataInfo;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => CommUtil.toBeDev(),
              child: Row(
                children: [
                  Text("${blogData.blogCount}", style: const TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(width: 2),
                  const Text("随笔", style: TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                Text("${blogData.articleCount}", style: const TextStyle(color: Colors.white, fontSize: 16)),
                const SizedBox(width: 2),
                const Text("文章", style: TextStyle(fontSize: 12, color: Colors.white70)),
              ],
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                Text("${blogData.commentCount}", style: const TextStyle(color: Colors.white, fontSize: 16)),
                const SizedBox(width: 2),
                const Text("评论", style: TextStyle(fontSize: 12, color: Colors.white70)),
              ],
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                Text("${blogData.viewCount}", style: const TextStyle(color: Colors.white, fontSize: 16)),
                const SizedBox(width: 2),
                const Text("阅读", style: TextStyle(fontSize: 12, color: Colors.white70)),
              ],
            ),
          ],
        );
      },
    );
  }
}
