import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/html_css_api.dart';
import 'package:flutter_cnblog/business/home/blog_share_screen.dart';
import 'package:flutter_cnblog/common/constant/content_type.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/svg_action_icon.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:flutter_cnblog/theme/shape.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UserBlogDetailScreen extends HookWidget {
  final UserBlog userBlog;

  const UserBlogDetailScreen(this.userBlog, {super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(true);

    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: Text(userBlog.title),
        actions: <Widget>[
          IconButton(
            icon: const SvgActionIcon(name: "more_hor"),
            onPressed: () => showMaterialModalBottomSheet(
              context: context,
              backgroundColor: const Color.fromRGBO(247, 248, 250, 1),
              duration: const Duration(milliseconds: 200),
              shape: bottomSheetBorder,
              builder: (_) => BlogShareScreen(userBlog.toBlogShare()),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            onWebViewCreated: (controller) async {
              final String string = await htmlCssApi.injectCss(userBlog.url, ContentType.blog);
              await controller.loadData(data: string, baseUrl: Uri.parse(ContentType.blog.host));
            },
            onPageCommitVisible: (controller, url) => isLoading.value = false,
          ),
          Visibility(visible: isLoading.value, child: const CenterProgressIndicator())
        ],
      ),
    );
  }
}
