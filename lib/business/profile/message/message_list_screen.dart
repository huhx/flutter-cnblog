import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/html_css_api.dart';
import 'package:flutter_cnblog/common/constant/content_type.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/model/message.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MessageListScreen extends StatefulWidget {
  final MessageType messageType;

  const MessageListScreen(this.messageType, {Key? key}) : super(key: key);

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InAppWebView(
            onWebViewCreated: (controller) async {
              final String url = "https://msg.cnblogs.com/${widget.messageType.path}";
              final String string = await htmlCssApi.injectCss(url, ContentType.message);
              await controller.loadData(data: string, baseUrl: Uri.parse(ContentType.message.host));
            },
            onPageCommitVisible: (controller, url) async {
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
