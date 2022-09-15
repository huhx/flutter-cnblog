import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/official_blog_api.dart';
import 'package:flutter_cnblog/business/home/blog_detail_screen.dart';
import 'package:flutter_cnblog/business/profile/official/official_blog_review_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/empty_widget.dart';
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/official_blog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OfficialBlogListScreen extends StatefulWidget {
  const OfficialBlogListScreen({Key? key}) : super(key: key);

  @override
  State<OfficialBlogListScreen> createState() => _OfficialBlogListScreenState();
}

class _OfficialBlogListScreenState extends State<OfficialBlogListScreen> {
  final StreamList<OfficialBlog> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
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
      body: StreamBuilder(
        stream: streamList.stream,
        builder: (context, snap) {
          if (!snap.hasData) return const CenterProgressIndicator();
          final List<OfficialBlog> officialBlogs = snap.data as List<OfficialBlog>;

          if (officialBlogs.isEmpty) {
            return const EmptyWidget();
          }

          return SmartRefresher(
            controller: streamList.refreshController,
            onRefresh: () => streamList.onRefresh(),
            onLoading: () => streamList.onLoading(),
            enablePullUp: true,
            child: ListView.builder(
              itemCount: officialBlogs.length,
              itemBuilder: (_, index) => OfficialBlogItem(blog: officialBlogs[index], key: ValueKey(officialBlogs[index].id)),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    streamList.dispose();
    super.dispose();
  }
}

class OfficialBlogItem extends StatelessWidget {
  final OfficialBlog blog;

  const OfficialBlogItem({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (blog.isReview) {
          context.goto(OfficialBlogReviewScreen(blog));
        } else {
          context.goto(BlogDetailScreen(blog: blog.toDetail()));
        }
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(blog.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
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
