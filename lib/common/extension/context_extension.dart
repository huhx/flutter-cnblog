import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/cancel_confirm_dialog.dart';

extension ContextExtensions on BuildContext {
  Future<T?> goto<T extends Object?>(Widget widget) async {
    return Navigator.push(this, MaterialPageRoute<T>(builder: (_) => widget));
  }

  Future<T?> gotoLogin<T extends Object?>(Widget widget) async {
    return Navigator.push(this, CupertinoPageRoute<T>(builder: (_) => widget, fullscreenDialog: true));
  }

  Future<T?> replace<T extends Object?>(Widget widget) async {
    return Navigator.pushReplacement(this, MaterialPageRoute<T>(builder: (_) => widget));
  }

  void pop<T extends Object?>([T? result]) {
    Navigator.pop<T>(this, result);
  }

  bool isDarkMode() {
    return MediaQuery.of(this).platformBrightness == Brightness.dark;
  }

  void showSnackBar(String content, {duration = 1}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(seconds: duration),
      ),
    );
  }

  void showCommDialog({required VoidCallback callback, title = '删除', content = '确定要删除?'}) {
    showDialog(
      context: this,
      builder: (_) => CancelConfirmDialog(
        title: title,
        content: content,
        callback: callback,
      ),
    );
  }
}
