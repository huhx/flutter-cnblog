import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/blog_api.dart';
import 'package:flutter_cnblog/business/home/blog_item.dart';
import 'package:flutter_cnblog/common/constant/comm_constant.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeCategoryScreen extends StatefulWidget {
  const HomeCategoryScreen({Key? key}) : super(key: key);

  @override
  State<HomeCategoryScreen> createState() => _HomeCategoryScreenState();
}

class _HomeCategoryScreenState extends State<HomeCategoryScreen> {
  final StreamList<BlogResp> streamList = StreamList(firstKey: 1, pageSize: pageSize);

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    final List<BlogResp> blogList = await blogApi.getHomeBlogs(pageKey, pageSize);
    streamList.addAll(blogList);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamList.stream,
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final List<BlogResp> blogs = snap.data as List<BlogResp>;

        return SmartRefresher(
          controller: streamList.refreshController,
          onRefresh: () => streamList.onRefresh(),
          onLoading: () => streamList.onLoading(),
          enablePullUp: true,
          child: ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (_, index) => BlogItem(blog: blogs[index], key: ValueKey(blogs[index].id)),
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
