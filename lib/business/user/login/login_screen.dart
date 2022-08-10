import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/common/constant/auth_request.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: const Text("博客园登录"),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: AuthRequest.getAuthorizeUrl(),
        onWebViewCreated: (_) {
          logger.d('加载url：${AuthRequest.getAuthorizeUrl()}');
        },
        onPageFinished: (url) async {
          if (url.startsWith(AuthRequest.callbackUrl)) {
            logger.d('加载完成：$url');
            final String code = AuthRequest.getCodeFromUrl(url);
            await ref.watch(sessionProvider.notifier).login(code);

            if (mounted) {
              Navigator.pop(context);
            }
          }
        },
      ),
    );
  }
}
