import 'package:flutter/material.dart';
import 'package:flutter_cnblog/theme/theme.dart';

import 'svg_icon.dart';

class CustomNavigationBarItem extends BottomNavigationBarItem {
  final String iconName;
  final String text;

  CustomNavigationBarItem({
    required this.iconName,
    required this.text,
  }) : super(
          icon: SvgIcon(name: iconName, size: 20),
          label: text,
          activeIcon: SvgIcon(name: iconName, color: themeColor, size: 20),
        );
}
