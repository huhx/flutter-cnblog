import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/bookmark_api.dart';
import 'package:flutter_cnblog/api/html_css_api.dart';
import 'package:flutter_cnblog/api/user_blog_api.dart';
import 'package:flutter_cnblog/business/home/blog_comment_list_screen.dart';
import 'package:flutter_cnblog/business/profile/user_profile_detail_screen.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/business/user/login/login_screen.dart';
import 'package:flutter_cnblog/common/constant/content_type.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/component/svg_action_icon.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/blog_share.dart';
import 'package:flutter_cnblog/model/detail_model.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/model/user_blog.dart';
import 'package:flutter_cnblog/theme/shape.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'blog_share_screen.dart';

class BlogDetailScreen extends HookConsumerWidget {
  final DetailModel blog;

  final TextEditingController editingController = TextEditingController();

  BlogDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(true);
    final User? user = ref.watch(sessionProvider);
    final postId = useState<int?>(blog.id);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const AppbarBackButton(),
        title: AppBarTitle(blog),
        actions: <Widget>[
          IconButton(
            icon: const SvgActionIcon(name: "more_hor"),
            onPressed: () async {
              if (user == null) {
                final bool? isSuccess = await context.gotoLogin(const LoginScreen());
                if (isSuccess == null) return;
              }
              final bool isMark = await bookmarkApi.isMark(blog.url);
              final BlogShareSetting setting = BlogShareSetting(isMark: isMark, isDarkMode: context.isDarkMode);

              showMaterialModalBottomSheet(
                context: context,
                duration: const Duration(milliseconds: 200),
                shape: bottomSheetBorder,
                builder: (_) => BlogShareScreen(blog: blog.toBlogShare(), shareSetting: setting),
              );
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: InAppWebView(
                  onWebViewCreated: (controller) async {
                    final String string = await htmlCssApi.injectCss(blog.url, ContentType.blog);
                    postId.value = blog.id ?? RegExp(r"var cb_entryId = ([0-9]+)").firstMatch(string)!.group(1)!.toInt();
                    await controller.loadData(data: string, baseUrl: Uri.parse(ContentType.blog.host));
                  },
                  onPageCommitVisible: (controller, url) => isLoading.value = false,
                ),
              ),
              Align(alignment: Alignment.bottomCenter, child: BottomComment(blog, postId.value))
            ],
          ),
          Visibility(visible: isLoading.value, child: const CenterProgressIndicator()),
        ],
      ),
    );
  }
}

class AppBarTitle extends ConsumerWidget {
  final DetailModel blog;

  const AppBarTitle(this.blog, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(sessionProvider);

    return Row(
      children: [
        InkWell(
          child: CircleImage(url: blog.avatar ?? "", size: 28),
          onTap: () async {
            if (user == null) {
              final bool? isSuccess = await context.gotoLogin(const LoginScreen());
              if (isSuccess == null) return;
            }
            context.goto(UserProfileDetailScreen(blog.toUserInfo()));
          },
        ),
        const SizedBox(width: 6),
        Text(blog.name!, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

class BottomComment extends HookConsumerWidget {
  final DetailModel blog;
  final int? postId;

  BottomComment(this.blog, this.postId, {super.key});

  final TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(sessionProvider);
    final buttonEnable = useState(false);
    final commentCount = useState(blog.commentCount ?? 0);
    final diggCount = useState(blog.diggCount ?? 0);

    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: TextFormField(
                controller: editingController,
                style: Theme.of(context).textTheme.bodyText2,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                minLines: 1,
                onChanged: (value) => buttonEnable.value = value.isNotEmpty,
                decoration: InputDecoration(
                  hintText: "????????????",
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
          if (buttonEnable.value)
            ElevatedButton(
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              onPressed: () async {
                final BlogCommentCreateReq request = BlogCommentCreateReq(
                  postId: blog.id!,
                  body: editingController.text,
                  parentCommentId: 0,
                );
                final BlogCommentCreateResp resp = await userBlogApi.addComment(blog.blogName!, request);
                if (resp.isSuccess) {
                  editingController.clear();
                  buttonEnable.value = false;
                  commentCount.value = commentCount.value + 1;
                  CommUtil.toast(message: "????????????!");
                } else {
                  CommUtil.toast(message: resp.message);
                }
              },
              child: const Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('??????')),
            )
          else
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    if (user == null) {
                      final bool? isSuccess = await context.gotoLogin(const LoginScreen());
                      if (isSuccess == null) return;
                    }
                    final BlogDiggReq request = BlogDiggReq(voteType: VoteType.digg, postId: postId!, isAbandoned: false);
                    final BlogDiggResp result = await userBlogApi.diggBlog(blog.blogName!, request);
                    if (result.isSuccess) {
                      CommUtil.toast(message: "????????????!");
                      diggCount.value = diggCount.value + 1;
                    } else {
                      CommUtil.toast(message: result.message);
                    }
                  },
                  icon: LikeBadge(diggCount.value),
                ),
                IconButton(
                  onPressed: () async {
                    if (user == null) {
                      final bool? isSuccess = await context.gotoLogin(const LoginScreen());
                      if (isSuccess == null) return;
                    }
                    context.goto(BlogCommentListScreen(blog.copyWith(postId: postId!), commentCount.value));
                  },
                  icon: CommentBadge(commentCount.value),
                ),
              ],
            )
        ],
      ),
    );
  }
}

class LikeBadge extends StatelessWidget {
  final int diggCount;

  const LikeBadge(this.diggCount, {super.key});

  @override
  Widget build(BuildContext context) {
    return Badge(
      animationType: BadgeAnimationType.scale,
      badgeColor: Colors.blueAccent,
      animationDuration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(5),
      badgeContent: Text("$diggCount", style: const TextStyle(fontSize: 9)),
      child: const SvgIcon(name: "like", color: Colors.grey, size: 22),
    );
  }
}

class CommentBadge extends StatelessWidget {
  final int commentCount;

  const CommentBadge(this.commentCount, {super.key});

  @override
  Widget build(BuildContext context) {
    return Badge(
      animationDuration: const Duration(milliseconds: 200),
      animationType: BadgeAnimationType.scale,
      padding: const EdgeInsets.all(5),
      badgeContent: Text("$commentCount", style: const TextStyle(fontSize: 9)),
      child: const SvgIcon(name: "comment", color: Colors.grey, size: 22),
    );
  }
}
