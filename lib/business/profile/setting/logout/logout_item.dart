import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogoutItem extends ConsumerWidget {
  const LogoutItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () async {
          await ref.watch(sessionProvider.notifier).logout();
          context.pop();
        },
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
}
