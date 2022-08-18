import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/model/question.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class QuestionDetailScreen extends StatefulWidget {
  final QuestionInfo question;

  const QuestionDetailScreen({Key? key, required this.question}) : super(key: key);

  @override
  State<QuestionDetailScreen> createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.question.title),
        leading: const AppbarBackButton(),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: widget.question.httpsUrl()),
            onPageCommitVisible: (controller, url) async {
              await controller.injectCSSCode(source: AppConfig.get("question_css"));
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
