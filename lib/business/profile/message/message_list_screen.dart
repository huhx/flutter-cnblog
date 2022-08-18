import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/model/message.dart';
import 'package:flutter_cnblog/util/app_config.dart';
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
            initialUrlRequest: URLRequest(url: Uri.parse("https://msg.cnblogs.com/${widget.messageType.path}")),
            onPageCommitVisible: (controller, url) async {
              await controller.injectCSSCode(source: AppConfig.get("message_css"));
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
