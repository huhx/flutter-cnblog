import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/bookmark_api.dart';
import 'package:flutter_cnblog/api/html_css_api.dart';
import 'package:flutter_cnblog/common/constant/content_type.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/component/svg_action_icon.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:flutter_cnblog/model/bookmark.dart';
import 'package:flutter_cnblog/theme/shape.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'blog_share_screen.dart';

class BlogDetailScreen extends HookWidget {
  final BlogResp blog;

  const BlogDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(true);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const AppbarBackButton(),
        title: AppBarTitle(blog),
        actions: <Widget>[
          FutureBuilder(
            future: bookmarkApi.isMark(blog.httpsUrl().toString()),
            builder: (context, snap) {
              if (!snap.hasData) return const SizedBox();
              bool isMark = snap.data as bool;
              return StatefulBuilder(
                builder: (context, setter) {
                  if (isMark) {
                    return const SvgIcon(name: "done", color: Colors.white, size: 20);
                  } else {
                    return TextButton(
                      onPressed: () async {
                        final BookmarkRequest request = BookmarkRequest(
                          wzLinkId: blog.id,
                          url: blog.url,
                          title: blog.title,
                        );
                        await bookmarkApi.add(request);
                        setter(() => isMark = !isMark);
                        CommUtil.toast(message: "收藏成功！");
                      },
                      child: const Text("收藏", style: TextStyle(color: Colors.white)),
                    );
                  }
                },
              );
            },
          ),
          IconButton(
            icon: const SvgActionIcon(name: "more_hor"),
            onPressed: () => showMaterialModalBottomSheet(
              context: context,
              backgroundColor: const Color.fromRGBO(247, 248, 250, 1),
              duration: const Duration(milliseconds: 200),
              shape: bottomSheetBorder,
              builder: (_) => BlogShareScreen(blog),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            onWebViewCreated: (controller) async {
              final String string = await htmlCssApi.injectCss(blog.toHttps(), ContentType.blog);
              await controller.loadData(data: string, baseUrl: Uri.parse(ContentType.blog.host));
            },
            onPageCommitVisible: (controller, url) => isLoading.value = false,
          ),
          Visibility(visible: isLoading.value, child: const CenterProgressIndicator())
        ],
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  final BlogResp blog;

  const AppBarTitle(this.blog, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: CircleImage(url: blog.avatar, size: 28),
          onTap: () => CommUtil.toBeDev(),
        ),
        const SizedBox(width: 6),
        Text(blog.author, style: const TextStyle(fontSize: 14)),
      ],
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
