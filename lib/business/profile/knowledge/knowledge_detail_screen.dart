import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/svg_action_icon.dart';
import 'package:flutter_cnblog/model/knowledge.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class KnowledgeDetailScreen extends StatefulWidget {
  final KnowledgeInfo knowledge;

  const KnowledgeDetailScreen(this.knowledge, {Key? key}) : super(key: key);

  @override
  State<KnowledgeDetailScreen> createState() => _KnowledgeDetailScreenState();
}

class _KnowledgeDetailScreenState extends State<KnowledgeDetailScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: Text(widget.knowledge.title, style: const TextStyle(fontSize: 15)),
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
            initialUrlRequest: URLRequest(url: Uri.parse("https://kb.cnblogs.com/page/${widget.knowledge.id}/")),
            onPageCommitVisible: (controller, url) async {
              await controller.injectCSSCode(source: AppConfig.get("knowledge_css"));
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
