import 'package:flutter/material.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';

import 'svg_icon.dart';

class AppbarBackButton extends StatelessWidget {
  final VoidCallback? callback;

  const AppbarBackButton({super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const SvgIcon(name: 'back', size: 18),
      onPressed: callback ?? () => context.pop(),
    );
  }
}
