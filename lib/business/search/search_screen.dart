import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_cnblog/theme/shape.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'search_list_screen.dart';

class SearchScreen extends HookConsumerWidget {
  final TextEditingController textEditingController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = useState("");
    
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppbarBackButton(),
          title: TextFormField(
            controller: textEditingController,
            autofocus: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (value) => query.value = value,
            decoration: InputDecoration(
              hintText: "搜索",
              suffixIcon: InkWell(
                onTap: () {
                  textEditingController.clear();
                  query.value = "";
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: SvgIcon(name: "search_clear", size: 18),
                ),
              ),
              suffixIconConstraints: const BoxConstraints(minHeight: 20, minWidth: 20),
              hintStyle: Theme.of(context).textTheme.bodyMedium!,
              isDense: true,
              filled: true,
              fillColor: Theme.of(context).colorScheme.background.withOpacity(0.5),
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              border: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
            ),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => query.value = textEditingController.text,
              child: const Text(
                "搜索",
                style: TextStyle(color: Colors.white),
              ),
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
