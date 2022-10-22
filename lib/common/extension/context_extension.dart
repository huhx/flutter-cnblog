import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/common/constant/enum_constant.dart';
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

  bool get isDarkMode {
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

  ScreenType get screenType {
    final MediaQueryData mediaQueryData = MediaQuery.of(this);
    final Orientation orientation = mediaQueryData.orientation;
    final double deviceWidth = orientation == Orientation.landscape ? mediaQueryData.size.height : mediaQueryData.size.width;

    if (deviceWidth > 950) {
      return ScreenType.desktop;
    }
    if (deviceWidth > 600) {
      return ScreenType.tablet;
    }
    return ScreenType.mobile;
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
