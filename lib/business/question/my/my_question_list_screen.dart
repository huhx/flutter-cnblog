import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyQuestionListScreen extends StatefulWidget {
  const MyQuestionListScreen({Key? key}) : super(key: key);

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
            initialUrlRequest: URLRequest(url: Uri.parse("https://q.cnblogs.com/list/myquestion")),
            onPageCommitVisible: (controller, url) async {
              await controller.injectCSSCode(source: AppConfig.get("my_question_css"));
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
