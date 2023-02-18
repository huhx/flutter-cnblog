import 'package:app_common_flutter/util.dart';
import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_instant_api.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/model/comment.dart';
import 'package:flutter_cnblog/model/instant.dart';
import 'package:flutter_cnblog/model/instant_comment.dart';
import 'package:flutter_cnblog/theme/shape.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';

class InstantDetailScreen extends HookWidget {
  final InstantInfo instant;

  const InstantDetailScreen(this.instant, {super.key});

  @override
  Widget build(BuildContext context) {
    final parentCommentId = useState(0);
    final focusNode = useState(FocusNode());
    final hintText = useState("");
    final commentCounts = useState(instant.commentCounts);

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
                  color: Theme.of(context).colorScheme.background,
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
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("所有回复 (${commentCounts.value})"),
                      const SizedBox(height: 8),
                      FutureBuilder<List<InstantComment>>(
                        future: userInstantApi.getInstantComments(instant.id),
                        builder: (context, snap) {
                          if (snap.hasError) {
                            return Container(
                              height: 100,
                              alignment: Alignment.center,
                              child: const Text("没有回复或者私密不能查看"),
                            );
                          }
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
                              return InkWell(
                                onTap: () {
                                  parentCommentId.value = instantComment.id;
                                  focusNode.value.requestFocus();
                                  hintText.value = "@${instantComment.toName}";
                                },
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  child: Container(
                                    color: Theme.of(context).colorScheme.background.withOpacity(0.4),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleImage(url: instantComment.avatar, size: 36),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(instantComment.toName),
                                                const SizedBox(height: 6),
                                                Text(instantComment.postDate),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Html(data: instantComment.content)
                                      ],
                                    ),
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
          CommentWidget(
            instant,
            parentCommentId.value,
            focusNode.value,
            hintText.value,
            () => commentCounts.value = commentCounts.value + 1,
          ),
        ],
      ),
    );
  }
}

class CommentWidget extends HookWidget {
  final InstantInfo instant;
  final int parentCommentId;
  final FocusNode focusNode;
  final String value;
  final VoidCallback callback;
  final TextEditingController editingController = TextEditingController();

  CommentWidget(this.instant, this.parentCommentId, this.focusNode, this.value, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    final content = useState("");

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: TextFormField(
                  controller: editingController,
                  focusNode: focusNode,
                  style: Theme.of(context).textTheme.bodyMedium,
                  keyboardType: TextInputType.multiline,
                  maxLines: 6,
                  minLines: 1,
                  onChanged: (value) => content.value = value,
                  decoration: InputDecoration(
                    hintText: value.isNotEmpty ? value : "输入评论",
                    hintStyle: const TextStyle(fontSize: 14),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
                        content: value.isNotEmpty ? "$value ${content.value}" : content.value,
                        ingId: instant.id,
                        parentCommentId: parentCommentId,
                      );
                      final CommentResp result = await userInstantApi.postInstantComment(request);
                      if (result.isSuccess) {
                        editingController.clear();
                        content.value = "";
                        callback();
                        CommUtil.toast(message: "发送成功！");
                      } else {
                        CommUtil.toast(message: result.message);
                      }
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
