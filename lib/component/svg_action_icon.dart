import 'package:flutter/material.dart';

import 'svg_icon.dart';

class SvgActionIcon extends StatelessWidget {
  final String name;

  const SvgActionIcon({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return SvgIcon(name: name, color: Colors.white, size: 20);
  }
}
