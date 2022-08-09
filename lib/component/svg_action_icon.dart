import 'package:flutter/material.dart';

import 'svg_icon.dart';

class SvgActionIcon extends StatelessWidget {
  final String iconName;

  const SvgActionIcon(this.iconName, {super.key});

  @override
  Widget build(BuildContext context) {
    return SvgIcon(name: iconName, color: Colors.white, size: 20);
  }
}
