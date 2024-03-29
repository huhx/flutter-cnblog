import 'package:app_common_flutter/extension.dart';
import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/bookmark_api.dart';
import 'package:flutter_cnblog/api/html_css_api.dart';
import 'package:flutter_cnblog/business/home/blog_share_screen.dart';
import 'package:flutter_cnblog/common/constant/content_type.dart';
import 'package:flutter_cnblog/model/blog_share.dart';
import 'package:flutter_cnblog/model/bookmark.dart';
import 'package:flutter_cnblog/theme/shape.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UserBookmarkDetailScreen extends HookConsumerWidget {
  final BookmarkInfo bookmark;

  const UserBookmarkDetailScreen(this.bookmark, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(true);

    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: Text(bookmark.title),
        actions: [
          SvgActionIcon(
            name: "more_hor",
            onPressed: () async {
              final bool isMark = await bookmarkApi.isMark(bookmark.url);
              final BlogShareSetting setting = BlogShareSetting(isMark: isMark, isDarkMode: context.isDarkMode);

              await showMaterialModalBottomSheet(
                context: context,
                duration: const Duration(milliseconds: 200),
                shape: bottomSheetBorder,
                builder: (_) => BlogShareScreen(blog: bookmark.toBlogShare(), shareSetting: setting),
              );
            },
          )
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            onWebViewCreated: (controller) async {
              final ContentType type = bookmark.type;
              final String string = await htmlCssApi.injectCss(bookmark.url, type);

              await controller.loadData(data: string, baseUrl: Uri.parse(type.host));
            },
            onPageCommitVisible: (controller, url) => isLoading.value = false,
          ),
          Visibility(visible: isLoading.value, child: const CenterProgressIndicator())
        ],
      ),
    );
  }
}
