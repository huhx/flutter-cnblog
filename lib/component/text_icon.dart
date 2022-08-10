import 'package:flutter/material.dart';

import 'svg_icon.dart';

class TextIcon extends StatelessWidget {
  final String icon;
  final int counts;

  const TextIcon({super.key, required this.icon, required this.counts});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgIcon(name: icon, size: 12, color: Colors.grey),
        const SizedBox(width: 4),
        Text("$counts", style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ],
    );
  }
}
