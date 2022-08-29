import 'package:flutter/material.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_cnblog/theme/shape.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'search_list_screen.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = useState("");
    String queryString = query.value;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppbarBackButton(),
          title: TextFormField(
            autofocus: true,
            initialValue: query.value,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (value) => query.value = value,
            onChanged: (value) => queryString = value,
            decoration: InputDecoration(
              hintText: "搜索",
              hintStyle: Theme.of(context).textTheme.bodyText2!,
              isDense: true,
              filled: true,
              fillColor: Theme.of(context).backgroundColor.withOpacity(0.5),
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              border: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
            ),
            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () => query.value = queryString,
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
        body: TabBarView(
          children: [
            SearchListScreen(SearchType.blog, query.value),
            SearchListScreen(SearchType.news, query.value),
            SearchListScreen(SearchType.question, query.value),
            SearchListScreen(SearchType.knowledge, query.value),
          ],
        ),
      ),
    );
  }
}
