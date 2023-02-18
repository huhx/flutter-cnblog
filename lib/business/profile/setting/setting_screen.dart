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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: ListView(
          children: const [
            ClearCacheItem(),
            Divider(),
            AppAboutItem(),
            // CheckUpdateItem(),
            Divider(),
            LogoutItem(),
          ],
        ),
      ),
    );
  }
}
