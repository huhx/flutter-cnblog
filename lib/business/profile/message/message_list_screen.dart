import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/html_css_api.dart';
import 'package:flutter_cnblog/common/constant/content_type.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/model/message.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MessageListScreen extends HookWidget {
  final MessageType messageType;

  const MessageListScreen(this.messageType, {super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(true);

    return Scaffold(
      body: Stack(
        children: [
          InAppWebView(
            onWebViewCreated: (controller) async {
              final String url = "https://msg.cnblogs.com/${messageType.path}";
              final String string = await htmlCssApi.injectCss(url, ContentType.message);
              await controller.loadData(data: string, baseUrl: Uri.parse(ContentType.message.host));
            },
            onPageCommitVisible: (controller, url) => isLoading.value = false,
          ),
          Visibility(visible: isLoading.value, child: const CenterProgressIndicator())
        ],
      ),
    );
  }
}
