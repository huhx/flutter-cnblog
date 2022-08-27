import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/search/search_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';

class ChatSearch extends StatelessWidget {
  final Color fillColor;
  final Color hintColor;

  const ChatSearch({super.key, required this.fillColor, required this.hintColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goto(const SearchScreen()),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Text("搜索", style: TextStyle(fontSize: 14, color: hintColor)),
      ),
    );
  }
}
