import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/read_log_api.dart';
import 'package:flutter_cnblog/business/news/news_detail_screen.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/business/user/login/login_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/detail_model.dart';
import 'package:flutter_cnblog/model/news.dart';
import 'package:flutter_cnblog/model/read_log.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class NewsItem extends ConsumerWidget {
  final NewsInfo news;

  const NewsItem({required this.news, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(sessionProvider);

    return InkWell(
      onTap: () async {
        if (user == null) {
          await context.goto(const LoginScreen());
        }
        final DetailModel detailModel = news.toDetail();
        await readLogApi.insert(ReadLog.of(type: ReadLogType.news, summary: news.summary, detailModel: detailModel));
        context.goto(NewsDetailScreen(detailModel));
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(news.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              const SizedBox(height: 6),
              Text(
                news.summary,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(news.submitter),
                      const SizedBox(width: 8),
                      TextIcon(icon: "comment", counts: news.commentCount),
                      const SizedBox(width: 10),
                      TextIcon(icon: "view", counts: news.viewCount),
                    ],
                  ),
                  Text(DateFormat("yyyy-MM-dd hh:mm").format(news.postDate))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
