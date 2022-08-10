import 'package:flutter/material.dart';
import 'package:flutter_cnblog/main.dart';
import 'package:flutter_cnblog/util/app_config.dart';

class InstantScreen extends StatefulWidget {
  const InstantScreen({Key? key}) : super(key: key);

  @override
  State<InstantScreen> createState() => _InstantScreenState();
}

class _InstantScreenState extends State<InstantScreen> {

  @override
  void initState() {
    super.initState();
    logger.d(AppConfig.get("token") ?? "none");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text("Instant Screen"),
    );
  }
}
