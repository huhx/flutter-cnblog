import 'package:flutter/material.dart';
import 'package:flutter_cnblog/business/search/search_screen.dart';
import 'package:flutter_cnblog/business/user/data/session_provider.dart';
import 'package:flutter_cnblog/business/user/login/login_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/theme/shape.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlogSearch extends ConsumerWidget {
  final Color fillColor;
  final Color hintColor;

  const BlogSearch({super.key, required this.fillColor, required this.hintColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(sessionProvider);

    return InkWell(
      onTap: () async {
        if (user == null) {
          await context.goto(const LoginScreen());
        }
        context.goto(const SearchScreen());
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Text("搜索", style: TextStyle(fontSize: 14, color: hintColor)),
      ),
    );
  }
}

class BlogSearchView extends StatefulWidget {
  final Function(String) callback;
  final String query;

  const BlogSearchView(this.query, this.callback, {Key? key}) : super(key: key);

  @override
  State<BlogSearchView> createState() => _BlogSearchViewState();
}

class _BlogSearchViewState extends State<BlogSearchView> {
  late String query;

  @override
  void initState() {
    super.initState();
    query = widget.query;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (value) => widget.callback(value),
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
    );
  }
}
