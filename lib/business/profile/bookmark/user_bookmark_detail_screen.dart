import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/svg_action_icon.dart';
import 'package:flutter_cnblog/model/bookmark.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class UserBookmarkDetailScreen extends StatefulWidget {
  final BookmarkInfo bookmark;

  const UserBookmarkDetailScreen(this.bookmark, {Key? key}) : super(key: key);

  @override
  State<UserBookmarkDetailScreen> createState() => _UserBookmarkDetailScreenState();
}

class _UserBookmarkDetailScreenState extends State<UserBookmarkDetailScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: Text(widget.bookmark.title),
        actions: [
          IconButton(
            icon: const SvgActionIcon(name: "more_hor"),
            onPressed: () => CommUtil.toBeDev(),
          )
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.bookmark.url)),
            onPageCommitVisible: (controller, url) async {
              if (widget.bookmark.isNews()) {
                await controller.injectCSSCode(source: AppConfig.get("news_css"));
              } else {
                await controller.injectCSSCode(source: AppConfig.get("blog_css"));
              }
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
