import 'package:app_common_flutter/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/official_blog_api.dart';
import 'package:flutter_cnblog/api/read_log_api.dart';
import 'package:flutter_cnblog/business/home/blog_detail_screen.dart';
import 'package:flutter_cnblog/business/profile/official/official_blog_review_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:app_common_flutter/views.dart' hide TextIcon;
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/detail_model.dart';
import 'package:flutter_cnblog/model/official_blog.dart';
import 'package:flutter_cnblog/model/read_log.dart';

class OfficialBlogListScreen extends StatefulWidget {
  const OfficialBlogListScreen({super.key});

  @override
  State<OfficialBlogListScreen> createState() => _OfficialBlogListScreenState();
}

class _OfficialBlogListScreenState extends StreamState<OfficialBlogListScreen, OfficialBlog> {
  @override
  Future<void> fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<OfficialBlog> blogList = await officialBlogApi.getOfficialBlogs(pageKey);
      streamList.fetch(blogList, pageKey, pageSize: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: const Text("官方博客"),
      ),
      body: PagedView(
        streamList,
        (context, officialBlogs) => ListView.builder(
          itemCount: officialBlogs.length,
          itemBuilder: (_, index) => OfficialBlogItem(
            blog: officialBlogs[index],
            key: ValueKey(officialBlogs[index].id),
          ),
        ),
      ),
    );
  }
}

class OfficialBlogItem extends StatelessWidget {
  final OfficialBlog blog;

  const OfficialBlogItem({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (blog.isReview) {
          context.goto(OfficialBlogReviewScreen(blog));
        } else {
          final DetailModel detailModel = blog.toDetail();
          context.goto(BlogDetailScreen(blog: detailModel));
          final ReadLog readLog = ReadLog.of(
            type: ReadLogType.blog,
            summary: blog.summary,
            detailModel: detailModel,
          );
          readLogApi.insert(readLog);
        }
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blog.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 6),
              Text(
                blog.summary,
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
                      TextIcon(icon: "like", counts: blog.diggCount),
                      const SizedBox(width: 8),
                      TextIcon(icon: "comment", counts: blog.commentCount),
                      const SizedBox(width: 8),
                      TextIcon(icon: "view", counts: blog.viewCount),
                    ],
                  ),
                  Text(
                    blog.postDate,
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
