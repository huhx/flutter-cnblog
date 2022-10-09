import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/common/constant/auth_request.dart';
import 'package:flutter_cnblog/common/constant/constant.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
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
        leading: const AppbarBackButton(),
        title: const Text("博客园登录"),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: AuthRequest.getAuthorizeUrl()),
            onPageCommitVisible: (controller, url) async {
              isLoading.value = false;
              if (url.toString().startsWith(AuthRequest.callbackUrl)) {
                CookieManager cookieManager = CookieManager.instance();
                final List<Cookie> cookies = await cookieManager.getCookies(url: url!);
                Cookie? cookie = cookies.firstWhere((element) => element.name == Constant.authCookieName);
                await PrefsUtil.saveCookie(cookie.value);

                logger.d('加载完成：$url');
                final String code = AuthRequest.getCodeFromUrl(url.toString());
                await ref.watch(sessionProvider.notifier).login(code);

                Navigator.pop(context);
              } else {
                if (Platform.isIOS) {
                  await controller.injectCSSFileFromAsset(assetFilePath: "assets/css/login.css");
                }
              }
            },
          ),
          Visibility(visible: isLoading.value, child: const CenterProgressIndicator())
        ],
      ),
    );
  }
}
