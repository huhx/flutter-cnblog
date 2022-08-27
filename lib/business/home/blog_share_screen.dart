import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/bookmark_api.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/bottom_sheet_item.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/blog_share.dart';
import 'package:flutter_cnblog/model/bookmark.dart';
import 'package:flutter_cnblog/util/comm_util.dart';

class BlogShareScreen extends StatefulWidget {
  final BlogShare blog;
  final BlogShareSetting setting;

  const BlogShareScreen({required this.blog, required this.setting, super.key});

  @override
  State<BlogShareScreen> createState() => _BlogShareScreenState();
}

class _BlogShareScreenState extends State<BlogShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24),
      alignment: Alignment.bottomCenter,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShareItem(icon: 'share_moment', label: '朋友圈', callback: () => CommUtil.toBeDev()),
              ShareItem(icon: 'share_wechat', label: '微信', callback: () => CommUtil.toBeDev()),
              ShareItem(icon: 'share_qq_zone', label: '空间', callback: () => CommUtil.toBeDev()),
              ShareItem(icon: 'share_qq', label: 'QQ', callback: () => CommUtil.toBeDev()),
              ShareItem(icon: 'share_weibo', label: '微博', callback: () => CommUtil.toBeDev()),
            ],
          ),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShareItem(
                icon: 'share_bookmark',
                label: widget.setting.isMark ? "取消收藏" : "收藏",
                color: widget.setting.isMark ? Colors.blueAccent : null,
                callback: () async {
                  if (widget.setting.isMark) {
                    CommUtil.toBeDev();
                  } else {
                    await bookmarkApi.add(BookmarkRequest(wzLinkId: widget.blog.id, url: widget.blog.url, title: widget.blog.title));
                  }
                  context.pop();
                },
              ),
              ShareItem(icon: 'share_font_size', label: '字号设置', callback: () => CommUtil.toBeDev()),
              ShareItem(icon: 'share_dark_mode', label: '深色模式', callback: () => CommUtil.toBeDev()),
              ShareItem(icon: 'share_copy_link', label: '复制链接', callback: () => CommUtil.toBeDev()),
              ShareItem(icon: 'share_more', label: '更多', callback: () => CommUtil.toBeDev()),
            ],
          ),
          const SizedBox(height: 24),
          BottomSheetItem(text: "取消", callback: () => CommUtil.toBeDev())
        ],
      ),
    );
  }
}

class ShareItem extends StatelessWidget {
  final String icon;
  final Color? color;
  final String label;
  final VoidCallback callback;

  const ShareItem({
    super.key,
    required this.icon,
    this.color,
    required this.label,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            alignment: Alignment.center,
            child: SvgIcon(name: icon, size: 28, color: color),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey))
        ],
      ),
    );
  }
}
