import 'package:dio/dio.dart';
import 'package:flutter_cnblog/common/constant/token_type.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/util/dio_util.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

@RestApi(baseUrl: "https://api.cnblogs.com/api")
abstract class UserApi {
  factory UserApi(Dio dio) = _UserApi;

  @GET("/users")
  Future<User> currentUser();
}

final userApi = UserApi(RestClient.getInstance(tokenType: TokenType.user));
