import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/home/data/home_category.dart';

class HomeCategoryScreen extends StatefulWidget {
  final HomeCategory category;

  const HomeCategoryScreen({super.key, required this.category});

  @override
  State<HomeCategoryScreen> createState() => _HomeCategoryScreenState();
}

class _HomeCategoryScreenState extends State<HomeCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(widget.category.label),
    );
  }
}
