import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/category_parser.dart';
import 'package:flutter_cnblog/model/blog_resp.dart';
import 'package:flutter_cnblog/model/category.dart';

class CategoryApi {
  Future<List<CategoryList>> getAllCategories() async {
    final Response response = await Dio().get("https://www.cnblogs.com/aggsite/allsitecategories");
    return compute(CategoryParser.parseCategoryList, response.data as String);
  }

  Future<List<BlogResp>> getByCategory(int pageKey, String path) async {
    final Response response = await Dio().get("https://www.cnblogs.com$path/#p$pageKey");
    return compute(CategoryParser.parseCategory, response.data as String);
  }
}

final categoryApi = CategoryApi();
