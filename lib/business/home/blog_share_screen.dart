import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/bookmark_api.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/bottom_sheet_item.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/blog_share.dart';
import 'package:flutter_cnblog/model/bookmark.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class BlogShareScreen extends HookConsumerWidget {
  final BlogShare blog;
  final BlogShareSetting shareSetting;

  const BlogShareScreen({required this.blog, required this.shareSetting, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMark = useState(shareSetting.isMark);

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
              ShareItem(
                icon: 'share_moment',
                label: '朋友圈',
                callback: () async {
                  await share(context);
                  context.pop();
                },
              ),
              ShareItem(
                icon: 'share_wechat',
                label: '微信',
                callback: () async {
                  await share(context);
                  context.pop();
                },
              ),
              ShareItem(
                icon: 'share_qq_zone',
                label: '空间',
                callback: () async {
                  await share(context);
                  context.pop();
                },
              ),
              ShareItem(
                icon: 'share_qq',
                label: 'QQ',
                callback: () async {
                  await share(context);
                  context.pop();
                },
              ),
              ShareItem(
                icon: 'share_weibo',
                label: '微博',
                callback: () async {
                  await share(context);
                  context.pop();
                },
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShareItem(
                icon: 'share_bookmark',
                label: isMark.value ? "取消收藏" : "收藏",
                color: isMark.value ? Colors.blueAccent : null,
                callback: () async {
                  if (isMark.value) {
                    CommUtil.toBeDev();
                  } else {
                    isMark.value = true;
                    await bookmarkApi.add(BookmarkRequest(wzLinkId: blog.id, url: blog.url, title: blog.title));
                  }
                  context.pop();
                },
              ),
              ShareItem(
                icon: 'share_font_size',
                label: '字号设置',
                callback: () {
                  CommUtil.toBeDev();
                  context.pop();
                },
              ),
              ShareItem(
                icon: 'share_dark_mode',
                label: '深色模式',
                callback: () {
                  CommUtil.toBeDev();
                  context.pop();
                },
              ),
              ShareItem(
                icon: 'share_copy_link',
                label: '复制链接',
                callback: () async {
                  await CommUtil.copyText(blog.url);
                  context.pop();
                  context.showSnackBar('已复制');
                },
              ),
              ShareItem(
                icon: 'share_more',
                label: '更多',
                callback: () {
                  CommUtil.toBeDev();
                  context.pop();
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          BottomSheetItem(text: "取消", callback: () => CommUtil.toBeDev())
        ],
      ),
    );
  }

  Future<void> share(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final ShareResult shareResult = await Share.shareWithResult(
      blog.url,
      subject: blog.title,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
    context.showSnackBar("status = ${shareResult.status.toString()}");
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
