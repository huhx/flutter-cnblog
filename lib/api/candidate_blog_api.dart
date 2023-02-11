import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/candidate_parser.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';

class CandidateApi {
  Future<List<BlogResp>> getAllCandidates(int pageKey) async {
    final Response response = await Dio().get("https://www.cnblogs.com/candidate/#p$pageKey");
    return compute(CandidateParser.parseCandidateList, response.data as String);
  }
}

final candidateApi = CandidateApi();
