import 'package:app_common_flutter/views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/read_log_api.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';

class ClearCacheItem extends StatelessWidget {
  const ClearCacheItem({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text('清除缓存', style: Theme.of(context).textTheme.bodyLarge),
      trailing: const ListTileTrailing(),
      onTap: () => _showConfirmDialog(context),
    );
  }

  Future<void> _showConfirmDialog(BuildContext context) async {
    context.showCommDialog(
      callback: () async {
        await readLogApi.clear();
        context.pop();
      },
      title: '清除缓存',
      content: '你确定清除缓存?',
    );
  }
}
