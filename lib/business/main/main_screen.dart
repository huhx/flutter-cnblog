import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/home/home_screen.dart';
import 'package:flutter_cnblog/business/instant/instant_screen.dart';
import 'package:flutter_cnblog/business/news/news_screen.dart';
import 'package:flutter_cnblog/business/profile/profile_screen.dart';
import 'package:flutter_cnblog/business/question/question_screen.dart';
import 'package:flutter_cnblog/component/custom_navigation_bar_item.dart';
import 'package:flutter_cnblog/theme/theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var pageIndex = 0;
  final homeList = [
    const HomeScreen(),
    const NewsScreen(),
    const InstantScreen(),
    const QuestionScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        items: [
          CustomNavigationBarItem(iconName: 'main_blog', text: '博客'),
          CustomNavigationBarItem(iconName: 'main_moment', text: '新闻'),
          CustomNavigationBarItem(iconName: 'main_instant', text: '闪存'),
          CustomNavigationBarItem(iconName: 'main_question', text: '博问'),
          CustomNavigationBarItem(iconName: 'main_profile', text: '我的'),
        ],
        selectedItemColor: themeColor,
        type: BottomNavigationBarType.fixed,
        onTap: (value) => setState(() => pageIndex = value),
      ),
    );
  }
}
