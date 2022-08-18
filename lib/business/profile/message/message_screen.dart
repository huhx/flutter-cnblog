import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/model/message.dart';

import 'message_list_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppbarBackButton(),
          centerTitle: false,
          title: const TabBar(
            tabs: [
              Tab(text: "收件箱"),
              Tab(text: "发件箱"),
              Tab(text: "未读消息"),
            ],
            indicatorColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 1,
          ),
        ),
        body: const TabBarView(
          children: [
            MessageListScreen(MessageType.inbox),
            MessageListScreen(MessageType.outbox),
            MessageListScreen(MessageType.unread),
          ],
        ),
      ),
    );
  }
}
