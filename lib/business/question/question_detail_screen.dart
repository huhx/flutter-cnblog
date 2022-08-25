import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/html_css_api.dart';
import 'package:flutter_cnblog/common/constant/content_type.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/svg_action_icon.dart';
import 'package:flutter_cnblog/model/question.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
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
            onWebViewCreated: (controller) async {
              final String string = await htmlCssApi.injectCss(widget.question.toHttps(), ContentType.question);
              await controller.loadData(data: string, baseUrl: Uri.parse(ContentType.question.host));
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
