import 'package:flutter/material.dart';

import 'center_progress_indicator.dart';

class FirstPageProgressIndicator extends StatelessWidget {
  const FirstPageProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: CenterProgressIndicator(),
    );
  }
}

class NewPageProgressIndicator extends StatelessWidget {
  const NewPageProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: [
          SizedBox.fromSize(
            size: const Size(20, 20),
            child: const CenterProgressIndicator(radius: 10),
          ),
          const Text("加载中…", style: TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      ),
    );
  }
}

class NoMoreItemsIndicator extends StatelessWidget {
  const NoMoreItemsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: const Text(
        "没有更多内容!",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
