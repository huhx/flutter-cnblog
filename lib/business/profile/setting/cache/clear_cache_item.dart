import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/read_log_api.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';

class ClearCacheItem extends StatelessWidget {
  const ClearCacheItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => _buildShowConfirmDialog(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Text('清除缓存', style: TextStyle(fontSize: 14)),
            IconTheme(data: IconThemeData(color: Colors.grey), child: Icon(Icons.keyboard_arrow_right))
          ],
        ),
      ),
    );
  }

  Future<void> _buildShowConfirmDialog(BuildContext context) async {
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
