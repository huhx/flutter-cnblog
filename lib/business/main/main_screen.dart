import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/home/home_screen.dart';
import 'package:flutter_cnblog/business/instant/instant_screen.dart';
import 'package:flutter_cnblog/business/news/news_screen.dart';
import 'package:flutter_cnblog/business/profile/profile_screen.dart';
import 'package:flutter_cnblog/business/question/question_screen.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/business/user/login/login_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/custom_navigation_bar_item.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/theme/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  var pageIndex = 0;
  final homeList = [
    const HomeScreen(),
    const NewsScreen(),
    const QuestionScreen(),
    const InstantScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(sessionProvider);

    return Scaffold(
      body: homeList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        items: [
          CustomNavigationBarItem(iconName: 'main_blog', text: '博客'),
          CustomNavigationBarItem(iconName: 'main_news', text: '新闻'),
          CustomNavigationBarItem(iconName: 'main_question', text: '博问'),
          CustomNavigationBarItem(iconName: 'main_instant', text: '闪存'),
          CustomNavigationBarItem(iconName: 'main_profile', text: '我的'),
        ],
        selectedItemColor: themeColor,
        type: BottomNavigationBarType.fixed,
        onTap: (value) async {
          if (user == null && value == 3) {
            await context.goto(const LoginScreen());
          }
          setState(() => pageIndex = value);
        },
      ),
    );
  }
}
