import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/knowledge_parser.dart';
import 'package:flutter_cnblog/model/knowledge.dart';
import 'package:flutter_cnblog/util/dio_util.dart';

class KnowledgeApi {
  Future<List<KnowledgeInfo>> getKnowledgeList(int pageKey) async {
    final String url = "https://kb.cnblogs.com/$pageKey/";
    final Response response = await RestClient.withCookie().get(url);

    return compute(KnowledgeParser.parseKnowledgeList, response.data as String);
  }
}

final knowledgeApi = KnowledgeApi();
