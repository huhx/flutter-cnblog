import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogoutItem extends ConsumerWidget {
  const LogoutItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionModel = ref.watch(sessionProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => _buildShowConfirmDialog(context, sessionModel),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Text('退出登录', style: TextStyle(fontSize: 14)),
            IconTheme(data: IconThemeData(color: Colors.grey), child: Icon(Icons.keyboard_arrow_right))
          ],
        ),
      ),
    );
  }

  Future<void> _buildShowConfirmDialog(BuildContext context, SessionModel sessionModel) async {
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
