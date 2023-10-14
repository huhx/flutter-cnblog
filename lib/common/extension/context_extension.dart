import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/common/constant/enum_constant.dart';

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

  ScreenType get screenType {
    final MediaQueryData mediaQueryData = MediaQuery.of(this);
    final Orientation orientation = mediaQueryData.orientation;
    final double deviceWidth =
        orientation == Orientation.landscape ? mediaQueryData.size.height : mediaQueryData.size.width;

    if (deviceWidth > 950) {
      return ScreenType.desktop;
    }
    if (deviceWidth > 600) {
      return ScreenType.tablet;
    }
    return ScreenType.mobile;
  }
}
