import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/question/question_detail_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/question.dart';
import 'package:timeago/timeago.dart' as timeago;

class QuestionItem extends StatelessWidget {
  final QuestionInfo question;

  const QuestionItem({required this.question, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goto(QuestionDetailScreen(question: question.toDetail())),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(question.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              const SizedBox(height: 6),
              Text(
                question.summary,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleImage(url: question.avatar),
                      const SizedBox(width: 6),
                      Text(question.submitter, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(width: 10),
                      TextIcon(icon: "view", counts: question.viewCount),
                    ],
                  ),
                  Text(
                    timeago.format(question.postDate ?? question.answeredDate!),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
