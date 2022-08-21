import 'package:flutter/material.dart';
import 'package:flutter_cnblog/util/comm_util.dart';

class CheckUpdateItem extends StatelessWidget {
  const CheckUpdateItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => CommUtil.toBeDev(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Text('检查版本', style: TextStyle(fontSize: 14)),
            IconTheme(data: IconThemeData(color: Colors.grey), child: Icon(Icons.keyboard_arrow_right))
          ],
        ),
      ),
    );
  }
}
