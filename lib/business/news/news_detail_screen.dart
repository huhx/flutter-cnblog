import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/bookmark_api.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/model/bookmark.dart';
import 'package:flutter_cnblog/model/news.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsInfo news;

  const NewsDetailScreen(this.news, {Key? key}) : super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.news.submitter),
        leading: const AppbarBackButton(),
        actions: [
          FutureBuilder(
            future: bookmarkApi.isMark(widget.news.httpsUrl().toString()),
            builder: (context, snap) {
              if (!snap.hasData) return const SizedBox();
              bool isMark = snap.data as bool;
              return StatefulBuilder(
                builder: (context, setter) {
                  return Visibility(
                    visible: !isMark,
                    child: TextButton(
                      onPressed: () async {
                        final BookmarkRequest request = BookmarkRequest(
                          wzLinkId: widget.news.id,
                          url: widget.news.httpsUrl().toString(),
                          title: widget.news.title,
                        );
                        await bookmarkApi.add(request);
                        setter(() => isMark = !isMark);
                        CommUtil.toast(message: "收藏成功！");
                      },
                      child: const Text("收藏", style: TextStyle(color: Colors.white)),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: widget.news.httpsUrl()),
            onPageCommitVisible: (controller, url) async {
              await controller.injectCSSCode(source: AppConfig.get("news_css"));
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
