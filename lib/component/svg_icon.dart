import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String name;
  final Color? color;
  final double size;

  const SvgIcon({
    super.key,
    required this.name,
    this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/svg/$name.svg",
      colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
      height: size,
      width: size,
    );
  }
}
