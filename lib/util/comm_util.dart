import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommUtil {
  static void toBeDev() {
    Fluttertoast.showToast(
      msg: "正在开发当中...",
      backgroundColor: Colors.black,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
