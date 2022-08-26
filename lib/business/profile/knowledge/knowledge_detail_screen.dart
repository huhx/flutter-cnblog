import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/html_css_api.dart';
import 'package:flutter_cnblog/common/constant/content_type.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/svg_action_icon.dart';
import 'package:flutter_cnblog/model/knowledge.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class KnowledgeDetailScreen extends HookWidget {
  final KnowledgeInfo knowledge;

  const KnowledgeDetailScreen(this.knowledge, {super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(true);

    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: Text(knowledge.title, style: const TextStyle(fontSize: 15)),
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
              final String string = await htmlCssApi.injectCss(knowledge.urlString(), ContentType.knowledge);
              await controller.loadData(data: string, baseUrl: Uri.parse(ContentType.knowledge.host));
            },
            onPageCommitVisible: (controller, url) => isLoading.value = false,
          ),
          Visibility(visible: isLoading.value, child: const CenterProgressIndicator())
        ],
      ),
    );
  }
}