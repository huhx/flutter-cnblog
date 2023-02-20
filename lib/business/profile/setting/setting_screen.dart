import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/profile/setting/cache/clear_cache_item.dart';
import 'package:flutter_cnblog/business/profile/setting/logout/logout_item.dart';
import 'package:app_common_flutter/views.dart';

import 'about/app_about_item.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: const Text('设置'),
      ),
      body: ListView(
        children: [
          CupertinoListSection.insetGrouped(
            additionalDividerMargin: 8,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
            children: const [
              ClearCacheItem(),
              AppAboutItem(),
              LogoutItem(),
            ],
          ),
        ],
      ),
    );
  }
}
