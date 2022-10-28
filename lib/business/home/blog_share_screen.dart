import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/bookmark_api.dart';
import 'package:flutter_cnblog/business/main/theme_provider.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/bottom_sheet_item.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/blog_share.dart';
import 'package:flutter_cnblog/model/bookmark.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlogShareScreen extends HookConsumerWidget {
  final BlogShare blog;
  final BlogShareSetting shareSetting;

  const BlogShareScreen({required this.blog, required this.shareSetting, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMark = useState(shareSetting.isMark);
    final isDarkMode = useState(ref.read(themeProvider).themeMode == ThemeMode.dark);

    return Container(
      padding: const EdgeInsets.only(top: 24),
      alignment: Alignment.bottomCenter,
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShareItem(
                icon: 'share_bookmark',
                label: isMark.value ? "取消收藏" : "收藏",
                color: isMark.value ? Colors.blueAccent : null,
                callback: () async {
                  if (isMark.value) {
                    isMark.value = false;
                    await bookmarkApi.deleteByUrl(blog.url);
                  } else {
                    isMark.value = true;
                    await bookmarkApi.add(BookmarkRequest(wzLinkId: blog.id ?? 1, url: blog.url, title: blog.title));
                  }
                  context.pop();
                },
              ),
              ShareItem(
                icon: 'blog_share',
                label: '分享',
                callback: () async {
                  await context.share(blog.url, blog.title);
                  context.pop();
                },
              ),
              ShareItem(
                icon: isDarkMode.value ? "share_light_mode" : "share_dark_mode",
                label: isDarkMode.value ? "浅色模式" : "深色模式",
                callback: () {
                  if (isDarkMode.value) {
                    isDarkMode.value = false;
                    ref.read(themeProvider).setDark(false);
                  } else {
                    isDarkMode.value = true;
                    ref.read(themeProvider).setDark(true);
                  }
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
            ],
          ),
          const SizedBox(height: 24),
          BottomSheetItem(text: "取消", callback: () {})
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
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
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
