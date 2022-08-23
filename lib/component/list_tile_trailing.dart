import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';

class ListTileTrailing extends StatelessWidget {
  const ListTileTrailing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IconTheme(
      data: IconThemeData(color: Colors.grey),
      child: SvgIcon(name: "right", size: 14),
    );
  }
}
