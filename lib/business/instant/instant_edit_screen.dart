import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cnblog/api/user_instant_api.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/svg_icon.dart';
import 'package:flutter_cnblog/model/comment.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InstantEditScreen extends HookConsumerWidget {
  const InstantEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flag = useState(InstantFlag.public);
    final content = useState("");

    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: const Text("发布闪存"),
        actions: [
          IconButton(
            onPressed: content.value.isEmpty
                ? null
                : () async {
                    final InstantReq instant = InstantReq(content: content.value, instantFlag: flag.value);
                    final InstantResp result = await userInstantApi.postInstant(instant);
                    if (result.isSuccess) {
                      CommUtil.toast(message: "创建成功!");
                      context.pop();
                    } else {
                      CommUtil.toast(message: "创建失败! ${result.responseText}");
                    }
                  },
            icon: const SvgIcon(
              name: "send",
              size: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            TextFormField(
              showCursor: true,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: const InputDecoration.collapsed(hintText: "发布闪存..."),
              keyboardType: TextInputType.multiline,
              onChanged: (value) => content.value = value,
              maxLines: 5,
              maxLength: 300,
              inputFormatters: [LengthLimitingTextInputFormatter(300)],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoSwitch(
                  value: flag.value == InstantFlag.public,
                  onChanged: (value) {
                    flag.value = value ? InstantFlag.public : InstantFlag.private;
                  },
                ),
                const Text(("是否公开"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
