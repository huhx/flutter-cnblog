import 'package:app_common_flutter/extension.dart';
import 'package:app_common_flutter/views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogoutItem extends ConsumerWidget {
  const LogoutItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionModel = ref.watch(sessionProvider.notifier);

    return CupertinoListTile(
      title: Text('退出登录', style: Theme.of(context).textTheme.bodyLarge),
      trailing: const ListTileTrailing(),
      onTap: () => _buildShowConfirmDialog(context, sessionModel),
    );
  }

  Future<void> _buildShowConfirmDialog(
    BuildContext context,
    SessionModel sessionModel,
  ) async {
    context.showCommDialog(
      callback: () async {
        await sessionModel.logout();
        context.pop();
      },
      title: '退出登录',
      content: '你确定退出登录?',
    );
  }
}
