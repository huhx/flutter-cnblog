import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_instant_api.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/model/comment.dart';
import 'package:flutter_cnblog/model/instant.dart';
import 'package:flutter_cnblog/model/instant_comment.dart';
import 'package:flutter_cnblog/theme/shape.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';

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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
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
                      const SizedBox(height: 8),
                      FutureBuilder<List<InstantComment>>(
                        future: userInstantApi.getInstantComments(instant.id),
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
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              final InstantComment instantComment = comments[index];
                              return Card(
                                margin: EdgeInsets.zero,
                                child: Container(
                                  color: Theme.of(context).backgroundColor.withOpacity(0.4),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(instantComment.toName),
                                          Text(
                                            instantComment.postDate,
                                            style: const TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Html(data: instantComment.content)
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, __) => const Divider(),
                            itemCount: comments.length,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          CommentWidget(instant),
        ],
      ),
    );
  }
}

class CommentWidget extends HookWidget {
  final InstantInfo instant;

  const CommentWidget(this.instant, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = useState("");

    return Align(
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
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText2,
                  keyboardType: TextInputType.multiline,
                  maxLines: 6,
                  minLines: 1,
                  onChanged: (value) => content.value = value,
                  decoration: InputDecoration(
                    hintText: "输入评论",
                    hintStyle: const TextStyle(fontSize: 14),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    border: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              onPressed: content.value.isEmpty
                  ? null
                  : () async {
                      final InstantCommentReq request = InstantCommentReq(
                        content: content.value,
                        ingId: instant.id,
                        parentCommentId: 0,
                      );
                      await userInstantApi.postInstantComment(request);
                    },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('发送'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
