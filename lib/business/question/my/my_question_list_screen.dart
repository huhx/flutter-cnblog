import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/html_css_api.dart';
import 'package:flutter_cnblog/common/constant/content_type.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyQuestionListScreen extends HookWidget {
  const MyQuestionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(true);

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
            onPageCommitVisible: (controller, url) => isLoading.value = false,
          ),
          Visibility(visible: isLoading.value, child: const CenterProgressIndicator())
        ],
      ),
    );
  }
}
