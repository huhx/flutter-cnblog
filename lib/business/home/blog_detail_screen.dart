import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/component/svg_action_icon.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:timeago/timeago.dart' as timeago;

class BlogDetailScreen extends StatefulWidget {
  final BlogResp blog;

  const BlogDetailScreen({Key? key, required this.blog}) : super(key: key);

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: Text(widget.blog.title),
        actions: <Widget>[
          IconButton(
            icon: const SvgActionIcon(name: "more_hor"),
            onPressed: () => CommUtil.toBeDev(),
          )
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: widget.blog.httpsUrl()),
            onPageCommitVisible: (controller, url) async {
              await controller.injectCSSCode(source: AppConfig.get("blog_css"));
              setState(() => isLoading = false);
            },
          ),
          Visibility(
            visible: isLoading,
            child: const CenterProgressIndicator(),
          )
        ],
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
                BlogIconButton(name: "comment", onPressed: () => CommUtil.toBeDev()),
                BlogIconButton(name: "comment", onPressed: () => CommUtil.toBeDev()),
                BlogIconButton(name: "like", onPressed: () => CommUtil.toBeDev()),
                BlogIconButton(name: "star", onPressed: () => CommUtil.toBeDev())
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BlogIconButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;

  const BlogIconButton({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: IconButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        icon: SvgIcon(name: name, size: 18),
      ),
    );
  }
}
