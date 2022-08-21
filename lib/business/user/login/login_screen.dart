import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/common/constant/auth_request.dart';
import 'package:flutter_cnblog/common/constant/constant.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/main.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
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
              setState(() => isLoading = false);
              CookieManager cookieManager = CookieManager.instance();
              Cookie? cookie = await cookieManager.getCookie(url: url!, name: Constant.authCookieName);
              AppConfig.save("cookie", cookie!.value);
              if (url.toString().startsWith(AuthRequest.callbackUrl)) {
                logger.d('加载完成：$url');
                final String code = AuthRequest.getCodeFromUrl(url.toString());
                await ref.watch(sessionProvider.notifier).login(code);

                if (mounted) {
                  Navigator.pop(context);
                }
              }
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
