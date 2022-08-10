import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/business/user/login/login_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SessionModel sessionModel = ref.watch(sessionProvider.notifier);

    return Container(
      alignment: Alignment.center,
      child: sessionModel.isAuth
          ? Text("user name is ${sessionModel.displayName}")
          : InkWell(
              child: const Text("Profile Screen"),
              onTap: () => context.goto(const LoginScreen()),
            ),
    );
  }
}
