import 'package:flutter/cupertino.dart';
import 'package:flutter_cnblog/theme/theme.dart';

class CenterProgressIndicator extends StatelessWidget {
  final double radius;

  const CenterProgressIndicator({super.key, this.radius = 15});

  @override
  Widget build(BuildContext context) {
    return Center(child: CupertinoActivityIndicator(radius: radius, color: themeColor));
  }
}
