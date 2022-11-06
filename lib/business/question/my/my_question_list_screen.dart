import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/html_css_api.dart';
import 'package:flutter_cnblog/common/constant/content_type.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyQuestionListScreen extends StatefulWidget {
  const MyQuestionListScreen({super.key});

  @override
  State<MyQuestionListScreen> createState() => _MyQuestionListScreenState();
}

class _MyQuestionListScreenState extends State<MyQuestionListScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的提问"),
        leading: const AppbarBackButton(),
      ),
      body: Stack(
        children: [
          InAppWebView(
            onWebViewCreated: (controller) async {
              const String url = "https://q.cnblogs.com/list/myquestion";
              final String string = await htmlCssApi.injectCss(url, ContentType.myQuestion);
              await controller.loadData(data: string, baseUrl: Uri.parse(ContentType.myQuestion.host));
            },
            onPageCommitVisible: (controller, url) => setState(() => isLoading = false),
          ),
          Visibility(visible: isLoading, child: const CenterProgressIndicator())
        ],
      ),
    );
  }
}
