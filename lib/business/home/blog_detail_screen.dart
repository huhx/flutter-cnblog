import 'package:flutter/material.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';

class BlogDetailScreen extends StatefulWidget {
  final BlogResp blog;

  const BlogDetailScreen({Key? key, required this.blog}) : super(key: key);

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
