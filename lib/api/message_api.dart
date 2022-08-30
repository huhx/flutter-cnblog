import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnblog/common/parser/message_parser.dart';
import 'package:flutter_cnblog/model/message.dart';
import 'package:flutter_cnblog/util/dio_util.dart';

class MessageApi {
  Future<List<MessageInfo>> getMessageList(MessageType type, int pageKey) async {
    final String url = "https://msg.cnblogs.com/${type.path}/$pageKey";
    final Response response = await RestClient.withCookie().get(url);

    return compute(MessageParser.parseMessageList, response.data as String);
  }
}

final messageApi = MessageApi();
