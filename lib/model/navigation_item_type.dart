import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/home/home_screen.dart';
import 'package:flutter_cnblog/business/instant/instant_screen.dart';
import 'package:flutter_cnblog/business/news/news_screen.dart';
import 'package:flutter_cnblog/business/profile/profile_screen.dart';
import 'package:flutter_cnblog/component/custom_navigation_bar_item.dart';

enum NavigationItemType {
  blog("main_blog", "博客", 0, HomeScreen()),
  news("main_news", "新闻", 1, NewsScreen()),
  // question("main_question", "博问", 2, QuestionScreen()),
  instant("main_instant", "闪存", 2, InstantScreen()),
  profile("main_profile", "我的", 3, ProfileScreen());

  final String iconName;
  final String label;
  final int pageIndex;
  final Widget screen;

  static NavigationItemType getByIndex(int pageIndex) {
    return NavigationItemType.values
        .firstWhere((element) => element.pageIndex == pageIndex);
  }

  static List<BottomNavigationBarItem> toNavigationBarItems() {
    return NavigationItemType.values
        .map((item) => CustomNavigationBarItem(iconName: item.iconName, text: item.label))
        .toList();
  }

  const NavigationItemType(this.iconName, this.label, this.pageIndex, this.screen);
}