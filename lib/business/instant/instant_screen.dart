import 'package:flutter/material.dart';

class InstantScreen extends StatefulWidget {
  const InstantScreen({Key? key}) : super(key: key);

  @override
  State<InstantScreen> createState() => _InstantScreenState();
}

class _InstantScreenState extends State<InstantScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("Instant Screen"),
    );
  }
}
