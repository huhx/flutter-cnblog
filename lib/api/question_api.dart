import 'package:dio/dio.dart';
import 'package:flutter_cnblog/common/parser/question_parser.dart';
import 'package:flutter_cnblog/model/question.dart';

class QuestionApi {
  Future<List<QuestionInfo>> getAllQuestions(QuestionStatus status, int pageKey) async {
    final Response response = await Dio().get("https://q.cnblogs.com/list/${status.url}?page=$pageKey");
    return QuestionParser.parseQuestionList(response.data);
  }
}

final questionApi = QuestionApi();
