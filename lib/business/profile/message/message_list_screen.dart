import 'package:app_common_flutter/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/message_api.dart';
import 'package:flutter_cnblog/business/profile/message/message_detail_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/common/stream_consumer_state.dart';
import 'package:flutter_cnblog/model/message.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageListScreen extends StatefulHookConsumerWidget {
  final MessageType messageType;

  const MessageListScreen(this.messageType, {super.key});

  @override
  ConsumerState<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends StreamConsumerState<MessageListScreen, MessageInfo> {
  @override
  Future<void> fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<MessageInfo> messageList = await messageApi.getMessageList(widget.messageType, pageKey);
      streamList.fetch(messageList, pageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: true);

    return PagedView(
      streamList,
      (context, messages) => ListView.builder(
        itemCount: messages.length,
        itemBuilder: (_, index) => MessageItem(message: messages[index], key: ValueKey(messages[index].id)),
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  final MessageInfo message;

  const MessageItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => context.goto(MessageDetailScreen(message.toDetail())),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            child: Text(message.author[0]),
          ),
          title: Text(message.author, style: Theme.of(context).textTheme.bodyMedium),
          subtitle: Text(message.title, maxLines: 1),
          trailing: Text(message.postDate.substring(0, 10), style: const TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }
}
