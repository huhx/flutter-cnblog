import 'package:flutter/material.dart';
import 'package:flutter_cnblog/theme/shape.dart';

class CancelConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback callback;

  const CancelConfirmDialog({
    required this.title,
    required this.content,
    required this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      shape: dialogShape,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(content),
          const SizedBox(height: 30),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(
                child: const Text("取消", style: TextStyle(color: Colors.red)),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: const Text("确定", style: TextStyle(color: Colors.green)),
                onPressed: () {
                  Navigator.pop(context);
                  callback();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
