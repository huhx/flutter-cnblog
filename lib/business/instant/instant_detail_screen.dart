import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/instant_comment_api.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/component/svg_action_icon.dart';
import 'package:flutter_cnblog/model/instant.dart';
import 'package:flutter_cnblog/model/instant_comment.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:timeago/timeago.dart' as timeago;

class InstantDetailScreen extends StatefulWidget {
  final InstantInfo instant;

  const InstantDetailScreen(this.instant, {Key? key}) : super(key: key);

  @override
  State<InstantDetailScreen> createState() => _InstantDetailScreenState();
}

class _InstantDetailScreenState extends State<InstantDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: const Text("闪存详情"),
        actions: [
          IconButton(
            icon: const SvgActionIcon(name: "more_hor"),
            onPressed: () => CommUtil.toBeDev(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleImage(url: widget.instant.avatar, size: 36),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text(widget.instant.submitter), Text(widget.instant.postDate)],
                        ),
                      ],
                    ),
                    Html(data: widget.instant.content)
                  ],
                ),
              ),
              const Divider(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("所有回复 (${widget.instant.commentCounts})"),
                    FutureBuilder<List<InstantComment>>(
                      future: instantCommentApi.getInstantComments(widget.instant.id),
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
      ),
    );
  }
}

class InstantCommentItem extends StatefulWidget {
  final InstantComment instantComment;

  const InstantCommentItem(this.instantComment, {Key? key}) : super(key: key);

  @override
  State<InstantCommentItem> createState() => _InstantCommentItemState();
}

class _InstantCommentItemState extends State<InstantCommentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleImage(url: widget.instantComment.userIconUrl, size: 36),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.instantComment.userDisplayName),
                  Text(timeago.format(widget.instantComment.dateAdded)),
                ],
              ),
            ],
          ),
          Html(data: widget.instantComment.content)
        ],
      ),
    );
  }
}
