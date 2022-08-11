import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/blog_api.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:timeago/timeago.dart' as timeago;

class BlogDetailScreen extends StatefulWidget {
  final BlogResp blog;

  const BlogDetailScreen({Key? key, required this.blog}) : super(key: key);

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        actions: <Widget>[
          IconButton(
            icon: const SvgIcon(name: "more_hor", color: Colors.white),
            onPressed: () => CommUtil.toBeDev(),
          )
        ],
      ),
      body: FutureBuilder<String>(
        future: blogApi.getBlogContent(widget.blog.id),
        builder: (_, snap) {
          if (!snap.hasData) return const CenterProgressIndicator();
          return Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ListView(
                children: [
                  BlogHeader(blog: widget.blog),
                  BlogContent(content: snap.requireData),
                ],
              ),
              BlogFooter(blog: widget.blog)
            ],
          );
        },
      ),
    );
  }
}

class BlogHeader extends StatelessWidget {
  final BlogResp blog;

  const BlogHeader({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            blog.title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleImage(url: blog.avatar, size: 36),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(blog.author),
                      const SizedBox(height: 4),
                      Text(
                        "${timeago.format(blog.postDate)}  阅读 ${blog.viewCount}",
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(30, 24)),
                onPressed: () => CommUtil.toBeDev(),
                icon: const SvgIcon(name: "add", color: Colors.white, size: 10),
                label: const Text("关注", style: TextStyle(fontSize: 10)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BlogContent extends StatelessWidget {
  final String content;

  const BlogContent({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Html(
        data: content.substring(1, content.length - 1).replaceAll(r"\n", "<br>"),
      ),
    );
  }
}

class BlogFooter extends StatefulWidget {
  final BlogResp blog;

  const BlogFooter({Key? key, required this.blog}) : super(key: key);

  @override
  State<BlogFooter> createState() => _BlogFooterState();
}

class _BlogFooterState extends State<BlogFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 3,
            child: TextFormField(decoration: const InputDecoration(hintText: "输入评论...")),
          ),
          const SizedBox(width: 20),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: IconButton(
                    onPressed: () => CommUtil.toBeDev(),
                    padding: EdgeInsets.zero,
                    icon: const SvgIcon(name: "comment", size: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: IconButton(
                    onPressed: () => CommUtil.toBeDev(),
                    padding: EdgeInsets.zero,
                    icon: const SvgIcon(name: "comment", size: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: IconButton(
                    onPressed: () => CommUtil.toBeDev(),
                    padding: EdgeInsets.zero,
                    icon: const SvgIcon(name: "like", size: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: IconButton(
                    onPressed: () => CommUtil.toBeDev(),
                    padding: EdgeInsets.zero,
                    icon: const SvgIcon(name: "star", size: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
