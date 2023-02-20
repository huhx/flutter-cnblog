import 'package:app_common_flutter/views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/profile/setting/about/app_about_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';

class AppAboutItem extends StatelessWidget {
  const AppAboutItem({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text('关于', style: Theme.of(context).textTheme.bodyLarge),
      trailing: const ListTileTrailing(),
      onTap: () => context.goto(const AppAboutScreen()),
    );
  }
}
