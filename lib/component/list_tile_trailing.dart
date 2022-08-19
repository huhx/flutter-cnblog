import 'package:flutter/material.dart';

class ListTileTrailing extends StatelessWidget {
  const ListTileTrailing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IconTheme(
      data: IconThemeData(color: Colors.grey),
      child: Icon(Icons.keyboard_arrow_right),
    );
  }
}
