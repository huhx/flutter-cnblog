import 'package:app_common_flutter/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/search/search_provider.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_cnblog/theme/shape.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'my_search_list_screen.dart';

class MySearchScreen extends ConsumerWidget {
  const MySearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String query = ref.watch(searchProvider);
    final searchModel = ref.watch(searchProvider.notifier);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppbarBackButton(),
          title: TextFormField(
            initialValue: query,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (value) => searchModel.update(value),
            onChanged: (value) => query = value,
            decoration: InputDecoration(
              hintText: "Search",
              isDense: true,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              border: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
            ),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () => searchModel.update(query),
              child: const Text("搜索"),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "博客"),
              Tab(text: "博问"),
              Tab(text: "闪存"),
            ],
            indicatorColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 1,
          ),
        ),
        body: const TabBarView(
          children: [
            MySearchListScreen(MySearchType.blog),
            MySearchListScreen(MySearchType.question),
            MySearchListScreen(MySearchType.instant),
          ],
        ),
      ),
    );
  }
}
