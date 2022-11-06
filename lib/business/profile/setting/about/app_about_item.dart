import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/profile/setting/about/app_about_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';

class AppAboutItem extends StatelessWidget {
  const AppAboutItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => context.goto(const AppAboutScreen()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Text('关于', style: TextStyle(fontSize: 14)),
            IconTheme(data: IconThemeData(color: Colors.grey), child: Icon(Icons.keyboard_arrow_right))
          ],
        ),
      ),
    );
  }
}
