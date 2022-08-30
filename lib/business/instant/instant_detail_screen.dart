import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/instant_comment_api.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/instant.dart';
import 'package:flutter_cnblog/model/instant_comment.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:timeago/timeago.dart' as timeago;

class InstantDetailScreen extends StatelessWidget {
  final InstantInfo instant;

  const InstantDetailScreen(this.instant, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: const Text("闪存详情"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).backgroundColor,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleImage(url: instant.avatar, size: 36),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(instant.submitter), Text(instant.postDate)],
                          ),
                        ],
                      ),
                      Html(data: instant.content)
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("所有回复 (${instant.commentCounts})"),
                      FutureBuilder<List<InstantComment>>(
                        future: instantCommentApi.getInstantComments(instant.id),
                        builder: (context, snap) {
                          if (!snap.hasData) return const CenterProgressIndicator();
                          List<InstantComment> comments = snap.data as List<InstantComment>;
                          if (comments.isEmpty) {
                            return Container(
                              height: 100,
                              alignment: Alignment.center,
                              child: const Text("没有回复"),
                            );
                          }

                          return ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (_, index) => InstantCommentItem(comments[index]),
                            separatorBuilder: (_, __) => const Divider(),
                            itemCount: comments.length,
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Theme.of(context).backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.edit, size: 15),
                          SizedBox(width: 6),
                          Text("输入评论", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => CommUtil.toBeDev(),
                    icon: const SvgIcon(name: "comment", color: Colors.grey, size: 22),
                  ),
                  IconButton(
                    onPressed: () => CommUtil.toBeDev(),
                    icon: const SvgIcon(name: "like", color: Colors.grey, size: 22),
                  ),
                  IconButton(
                    onPressed: () => CommUtil.toBeDev(),
                    icon: const SvgIcon(name: "content_bookmark", color: Colors.grey, size: 22),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InstantCommentItem extends StatelessWidget {
  final InstantComment instantComment;

  const InstantCommentItem(this.instantComment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleImage(url: instantComment.userIconUrl, size: 36),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(instantComment.userDisplayName),
                  Text(timeago.format(instantComment.dateAdded)),
                ],
              ),
            ],
          ),
          Html(data: instantComment.content)
        ],
      ),
    );
  }
}
