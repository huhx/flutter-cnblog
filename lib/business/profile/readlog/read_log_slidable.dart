import 'package:app_common_flutter/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/read_log_api.dart';
import 'package:flutter_cnblog/business/home/blog_detail_screen.dart';
import 'package:flutter_cnblog/business/news/news_detail_screen.dart';
import 'package:flutter_cnblog/business/profile/knowledge/knowledge_detail_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/detail_model.dart';
import 'package:flutter_cnblog/model/read_log.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReadLogSlidable extends ConsumerWidget {
  final ReadLog readlog;
  final Function(String) onDelete;

  const ReadLogSlidable({
    required this.readlog,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      groupTag: "cnblog",
      key: ValueKey(readlog.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onDelete(readlog.id),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (_) => context.share(title: readlog.id, subject: "cnblog"),
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),
      child: ReadLogItem(readlog),
    );
  }
}

class ReadLogItem extends StatelessWidget {
  final ReadLog readLog;

  const ReadLogItem(this.readLog, {super.key});

  @override
  Widget build(BuildContext context) {
    final DetailModel detailModel = readLog.json;

    return InkWell(
      onTap: () {
        if (readLog.type == ReadLogType.blog) {
          context.goto(BlogDetailScreen(blog: detailModel));
          readLogApi.insert(ReadLog.of(
            type: ReadLogType.blog,
            summary: readLog.summary,
            detailModel: detailModel,
          ));
        } else if (readLog.type == ReadLogType.news) {
          context.goto(NewsDetailScreen(detailModel));
          readLogApi.insert(ReadLog.of(
            type: ReadLogType.news,
            summary: readLog.summary,
            detailModel: detailModel,
          ));
        } else if (readLog.type == ReadLogType.knowledge) {
          context.goto(KnowledgeDetailScreen(detailModel));
          readLogApi.insert(ReadLog.of(
            type: ReadLogType.knowledge,
            summary: readLog.summary,
            detailModel: detailModel,
          ));
        }
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.7),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      readLog.type.label,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      detailModel.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                readLog.summary,
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
                      if (detailModel.name != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            detailModel.name!,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      if (detailModel.diggCount != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: TextIcon(icon: "like", counts: detailModel.diggCount!),
                        ),
                      if (detailModel.commentCount != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: TextIcon(icon: "comment", counts: detailModel.commentCount!),
                        ),
                      if (detailModel.viewCount != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: TextIcon(icon: "view", counts: detailModel.viewCount!),
                        ),
                    ],
                  ),
                  Text(
                    timeago.format(DateTime.fromMillisecondsSinceEpoch(readLog.createTime)),
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
