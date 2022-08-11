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
    return const Padding(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: CenterProgressIndicator(),
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
