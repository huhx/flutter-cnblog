import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/model/question.dart';

class QuestionDetailScreen extends StatefulWidget {
  final QuestionInfo question;

  const QuestionDetailScreen({Key? key, required this.question}) : super(key: key);

  @override
  State<QuestionDetailScreen> createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.question.title),
        leading: const AppbarBackButton(),
      ),
      body: Column(
        children: [
          Text(
            widget.question.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Text(widget.question.summary)
        ],
      ),
    );
  }
}
