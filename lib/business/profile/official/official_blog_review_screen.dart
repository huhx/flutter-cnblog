import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/official_blog_api.dart';
import 'package:flutter_cnblog/business/home/blog_detail_screen.dart';
import 'package:flutter_cnblog/business/news/news_detail_screen.dart';
import 'package:flutter_cnblog/business/profile/user_profile_detail_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/list_tile_trailing.dart';
import 'package:flutter_cnblog/model/official_blog.dart';

class OfficialBlogReviewScreen extends StatelessWidget {
  final OfficialBlog blog;

  const OfficialBlogReviewScreen(this.blog, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(blog.title),
          leading: const AppbarBackButton(),
          bottom: const TabBar(
            tabs: [Tab(text: "热门随笔"), Tab(text: "热门新闻")],
            indicatorColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 1,
          ),
        ),
        body: FutureBuilder(
          future: officialBlogApi.getHotList(blog.url),
          builder: (context, snap) {
            if (!snap.hasData) return const CenterProgressIndicator();
            final List<OfficialHot> data = snap.data as List<OfficialHot>;
            final List<OfficialHot> blogList = data.where((item) => item.isBlog).toList();
            final List<OfficialHot> newsList = data.where((item) => !item.isBlog).toList();

            return TabBarView(
              children: [
                HotBlogList(blogList),
                HostNewsList(newsList),
              ],
            );
          },
        ),
      ),
    );
  }
}

class HotBlogList extends StatelessWidget {
  final List<OfficialHot> blogList;

  const HotBlogList(this.blogList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: blogList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => context.goto(BlogDetailScreen(blog: blogList[index].toDetail())),
          child: Card(
            child: ListTile(
              leading: InkWell(
                child: CircleAvatar(
                  child: Text(blogList[index].name.substring(0, 1)),
                ),
                onTap: () => context.goto(UserProfileDetailScreen(blogList[index].toInfo())),
              ),
              title: Text(blogList[index].name, style: Theme.of(context).textTheme.bodyText2),
              subtitle: Text(
                blogList[index].title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              trailing: const ListTileTrailing(),
            ),
          ),
        );
      },
    );
  }
}

class HostNewsList extends StatelessWidget {
  final List<OfficialHot> newsList;

  const HostNewsList(this.newsList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => context.goto(NewsDetailScreen(newsList[index].toDetail())),
          child: Card(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(newsList[index].title, overflow: TextOverflow.ellipsis, maxLines: 1),
            ),
          ),
        );
      },
    );
  }
}
