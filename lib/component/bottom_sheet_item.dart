import 'package:flutter/material.dart';

class BottomSheetItem extends StatelessWidget {
  final String text;
  final VoidCallback? callback;

  const BottomSheetItem({required this.text, this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        callback?.call();
      },
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(text),
      ),
    );
  }
}
