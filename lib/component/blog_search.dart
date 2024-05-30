import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/search/search_screen.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/business/user/login/login_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlogSearch extends ConsumerWidget {
  const BlogSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(sessionProvider);

    return InkWell(
      onTap: () async {
        if (user == null) {
          final bool? isSuccess = await context.gotoLogin(const LoginScreen());
          if (isSuccess == null) return;
        }
        context.goto(SearchScreen());
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: const Text("搜索", style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
