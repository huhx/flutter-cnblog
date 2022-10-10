import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_blog_api.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/empty_widget.dart';
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/detail_model.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:flutter_cnblog/theme/shape.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BlogCommentListScreen extends StatefulHookConsumerWidget {
  final DetailModel blog;
  final int counts;

  const BlogCommentListScreen(this.blog, this.counts, {Key? key}) : super(key: key);

  @override
  ConsumerState<BlogCommentListScreen> createState() => _BlogCommentListScreenState();
}

class _BlogCommentListScreenState extends ConsumerState<BlogCommentListScreen> {
  final StreamList<BlogComment> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  @override
  void dispose() {
    streamList.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final BlogCommentReq request = BlogCommentReq(postId: widget.blog.id!, pageIndex: pageKey);
      final List<BlogComment> blogList = await userBlogApi.queryComments(widget.blog.blogName!, request);
      streamList.fetch(blogList, pageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final parentCommentId = useState(0);
    final focusNode = useState(FocusNode());
    final hintText = useState("");

    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: Html(data: widget.blog.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: streamList.stream,
              builder: (context, snap) {
                if (!snap.hasData) return const CenterProgressIndicator();
                final List<BlogComment> comments = snap.data as List<BlogComment>;

                if (comments.isEmpty) {
                  return const EmptyWidget();
                }

                return SmartRefresher(
                  controller: streamList.refreshController,
                  onRefresh: () => streamList.onRefresh(),
                  onLoading: () => streamList.onLoading(),
                  enablePullUp: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: comments.length,
                    itemBuilder: (_, index) {
                      final BlogComment comment = comments[index];
                      return InkWell(
                        onTap: () {
                          parentCommentId.value = comment.id;
                          focusNode.value.requestFocus();
                          hintText.value = "@${comment.author}";
                        },
                        child: Card(
                          child: Container(
                            color: Theme.of(context).backgroundColor.withOpacity(0.4),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(child: Text(comment.author[0])),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(comment.author),
                                              Row(
                                                children: [
                                                  TextIcon(icon: "like", counts: comment.diggCount),
                                                  const SizedBox(width: 8),
                                                  TextIcon(icon: "dislike", counts: comment.buryCount),
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Text(comment.postDate),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Html(data: comment.content)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          CommentWidget(widget.blog, parentCommentId.value, focusNode.value, hintText.value),
        ],
      ),
    );
  }
}

class CommentWidget extends HookWidget {
  final DetailModel blog;
  final int parentCommentId;
  final FocusNode focusNode;
  final String value;
  final TextEditingController editingController = TextEditingController();

  CommentWidget(this.blog, this.parentCommentId, this.focusNode, this.value, {Key? key}) : super(key: key);

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
                  controller: editingController,
                  focusNode: focusNode,
                  style: Theme.of(context).textTheme.bodyText2,
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
                      final BlogCommentCreateReq request = BlogCommentCreateReq(
                        body: value.isNotEmpty ? "$value ${content.value}" : content.value,
                        postId: blog.id!,
                        parentCommentId: parentCommentId,
                      );
                      final BlogCommentCreateResp result = await userBlogApi.addComment(blog.blogName!, request);
                      if (result.isSuccess) {
                        editingController.clear();
                        content.value = "";
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
