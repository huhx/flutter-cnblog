import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/search/search_provider.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_cnblog/theme/shape.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'search_list_screen.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String query = ref.watch(searchProvider);
    final searchModel = ref.watch(searchProvider.notifier);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppbarBackButton(),
          title: TextFormField(
            initialValue: query,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (value) => searchModel.update(value),
            onChanged: (value) => query = value,
            decoration: const InputDecoration(
              hintText: "Search",
              isDense: true,
              filled: true,
              fillColor: Color.fromRGBO(249, 249, 249, 1),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              border: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
            ),
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => searchModel.update(query),
              child: const Text("搜索", style: TextStyle(color: Colors.white)),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "博客"),
              Tab(text: "新闻"),
              Tab(text: "博问"),
              Tab(text: "知识库"),
            ],
            indicatorColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 1,
          ),
        ),
        body: const TabBarView(
          children: [
            SearchListScreen(SearchType.blog),
            SearchListScreen(SearchType.news),
            SearchListScreen(SearchType.question),
            SearchListScreen(SearchType.knowledge),
          ],
        ),
      ),
    );
  }
}
