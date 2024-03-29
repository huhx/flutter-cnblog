import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/common/constant/auth_request.dart';
import 'package:flutter_cnblog/common/constant/constant.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/common/in_app_webview_config.dart';
import 'package:flutter_cnblog/main.dart';
import 'package:flutter_cnblog/util/prefs_util.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(true);

    return Scaffold(
      appBar: AppBar(
        leading: SvgActionIcon(name: 'close', onPressed: () => context.pop()),
        title: const Text("博客园登录"),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialOptions: InAppWebViewConfig(),
            initialUrlRequest: URLRequest(url: AuthRequest.authorizeUri),
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              final Uri url = navigationAction.request.url!;
              if (url.toString().startsWith(AuthRequest.callbackUrl)) {
                final CookieManager cookieManager = CookieManager.instance();
                final List<Cookie> cookies = await cookieManager.getCookies(url: url);
                final Cookie cookie = cookies.firstWhere((element) => element.name == Constant.authCookieName);
                await PrefsUtil.saveCookie(cookie.value);

                logger.d('加载完成：$url');
                final String code = AuthRequest.getCodeFromUrl(url.toString());
                await ref.watch(sessionProvider.notifier).login(code);
                Navigator.pop(context, true);

                return NavigationActionPolicy.CANCEL;
              }
              return NavigationActionPolicy.ALLOW;
            },
            onPageCommitVisible: (controller, url) async {
              await controller.injectCSSFileFromAsset(assetFilePath: "assets/css/login.css");
              isLoading.value = false;
            },
          ),
          Visibility(visible: isLoading.value, child: const CenterProgressIndicator())
        ],
      ),
    );
  }
}
