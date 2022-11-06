import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/message_api.dart';
import 'package:flutter_cnblog/business/profile/message/message_detail_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/empty_widget.dart';
import 'package:flutter_cnblog/model/message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageListScreen extends ConsumerStatefulWidget {
  final MessageType messageType;

  const MessageListScreen(this.messageType, {super.key});

  @override
  ConsumerState<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends ConsumerState<MessageListScreen> with AutomaticKeepAliveClientMixin {
  final StreamList<MessageInfo> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<MessageInfo> messageList = await messageApi.getMessageList(widget.messageType, pageKey);
      streamList.fetch(messageList, pageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: streamList.stream,
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final List<MessageInfo> messages = snap.data as List<MessageInfo>;

        if (messages.isEmpty) {
          return const EmptyWidget();
        }

        return SmartRefresher(
          controller: streamList.refreshController,
          onRefresh: () => streamList.onRefresh(),
          onLoading: () => streamList.onLoading(),
          enablePullUp: true,
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (_, index) => MessageItem(message: messages[index], key: ValueKey(messages[index].id)),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    streamList.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
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
          title: Text(message.author, style: Theme.of(context).textTheme.bodyText2),
          subtitle: Text(message.title, maxLines: 1),
          trailing: Text(message.postDate.substring(0, 10), style: const TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }
}
