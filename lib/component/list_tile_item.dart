import 'package:flutter/material.dart';

import 'list_tile_trailing.dart';

class ListTileItem extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;

  const ListTileItem({
    super.key,
    required this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    Widget middleWidget;
    if (subtitle == null) {
      middleWidget = title;
    } else {
      middleWidget = Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title,
            DefaultTextStyle(style: const TextStyle(color: Colors.grey), child: subtitle!),
          ],
        ),
      );
    }
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: Row(
                children: <Widget>[
                  leading,
                  const SizedBox(width: 24.0),
                  middleWidget,
                ],
              ),
            ),
            trailing ?? const ListTileTrailing(),
          ],
        ),
      ),
    );
  }
}
