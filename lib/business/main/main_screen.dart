import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/main/scroll_provider.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/business/user/login/login_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/model/navigation_item_type.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/theme/theme.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = useState(0);

    final User? user = ref.watch(sessionProvider);
    final ScrollModel scrollModel = ref.watch(scrollProvider.notifier);

    return Scaffold(
      body: NavigationItemType.getByIndex(pageIndex.value),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex.value,
        items: NavigationItemType.toNavigationBarItems(),
        selectedItemColor: themeColor,
        type: BottomNavigationBarType.fixed,
        onTap: (value) async {
          if (user == null && value == NavigationItemType.instant.pageIndex) {
            await context.goto(const LoginScreen());
          }
          pageIndex.value = value;
        },
      ),
    );
  }
}