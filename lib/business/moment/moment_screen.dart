import 'package:flutter/material.dart';

class MomentScreen extends StatefulWidget {
  const MomentScreen({Key? key}) : super(key: key);

  @override
  State<MomentScreen> createState() => _MomentScreenState();
}

class _MomentScreenState extends State<MomentScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("Moment Screen"),
    );
  }
}
