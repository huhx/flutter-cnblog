import 'package:app_common_flutter/util.dart';
import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';

class CheckUpdateItem extends StatelessWidget {
  const CheckUpdateItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => CommUtil.toBeDev(),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('检查版本', style: TextStyle(fontSize: 14)),
            ListTileTrailing(),
          ],
        ),
      ),
    );
  }
}
