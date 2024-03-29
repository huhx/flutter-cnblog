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
    final NavigationItemType itemType = NavigationItemType.getByIndex(pageIndex.value);

    return Scaffold(
      body: itemType.screen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex.value,
        items: NavigationItemType.toItems(),
        selectedItemColor: themeColor,
        type: BottomNavigationBarType.fixed,
        onTap: (value) async {
          if (user == null && value == NavigationItemType.instant.pageIndex) {
            final bool? isSuccess = await context.gotoLogin(const LoginScreen());
            if (isSuccess == null) return;
          }
          if (value != NavigationItemType.profile.pageIndex && value == pageIndex.value) {
            if (scrollModel.isNotTop(itemType.name)) {
              scrollModel.scrollToTop(itemType.name);
            }
          }
          pageIndex.value = value;
        },
      ),
    );
  }
}
