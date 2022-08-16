import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class UserBookmarkDetailScreen extends StatefulWidget {
  final String url;

  const UserBookmarkDetailScreen(this.url, {Key? key}) : super(key: key);

  @override
  State<UserBookmarkDetailScreen> createState() => _UserBookmarkDetailScreenState();
}

class _UserBookmarkDetailScreenState extends State<UserBookmarkDetailScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const AppbarBackButton()),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
            onPageCommitVisible: (controller, url) async {
              await controller.injectCSSCode(source: AppConfig.get("css"));
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
