import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/bottom_sheet_item.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/blog_share.dart';
import 'package:flutter_cnblog/util/comm_util.dart';

class BlogShareScreen extends StatelessWidget {
  final BlogShare blog;

  const BlogShareScreen(this.blog, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("分享", style: TextStyle(color: Colors.white, fontSize: 20)),
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
              ShareItem(icon: 'share_bookmark', label: '收藏', callback: () => CommUtil.toBeDev()),
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
  final String label;
  final VoidCallback callback;

  const ShareItem({
    super.key,
    required this.icon,
    required this.label,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          color: Colors.white,
          alignment: Alignment.center,
          child: SvgIcon(name: icon, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey))
      ],
    );
  }
}
