import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommUtil {
  static Future<void> copyText(String text) {
    return Clipboard.setData(ClipboardData(text: text));
  }

  static void toast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void toBeDev() {
    toast(message: "正在开发当中...");
  }
}
