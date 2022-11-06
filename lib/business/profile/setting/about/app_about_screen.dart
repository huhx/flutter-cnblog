import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/util/app_config.dart';

class AppAboutScreen extends StatelessWidget {
  const AppAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: const Text("关于博客园"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          const Text(
            "博客园简介 - 代码改变世界",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            height: 120,
            width: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage('assets/image/logo.png')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: Text("此版本为${AppConfig.get("version")}", textAlign: TextAlign.center),
          ),
          const Text(
            '''      博客园创立于2004年1月，是一个面向开发者的知识分享社区。自创建以来，博客园一直致力并专注于为开发者打造一个纯净的技术交流社区，推动并帮助开发者通过互联网分享知识， 从而让更多开发者从中受益。博客园的使命是帮助开发者用代码改变世界。
          ''',
            style: TextStyle(height: 1.5),
          )
        ],
      ),
    );
  }
}
