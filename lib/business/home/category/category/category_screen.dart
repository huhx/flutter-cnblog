import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/category_api.dart';
import 'package:flutter_cnblog/business/home/category/category/category_list_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/appbar_back_button.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/list_scroll_physics.dart';
import 'package:flutter_cnblog/component/svg_action_icon.dart';
import 'package:flutter_cnblog/model/blog_category.dart';
import 'package:flutter_cnblog/util/comm_util.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBackButton(),
        title: const Text("所有分类"),
        actions: [
          IconButton(
            icon: const SvgActionIcon(name: "more_hor"),
            onPressed: () => CommUtil.toBeDev(),
          )
        ],
      ),
      body: FutureBuilder<List<CategoryList>>(
        future: categoryApi.getAllCategories(),
        builder: (context, snap) {
          if (!snap.hasData) return const CenterProgressIndicator();
          List<CategoryList> categoryList = snap.data as List<CategoryList>;
          return ListView.separated(
            physics: const ListScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: categoryList.length,
            separatorBuilder: (context, index) => const Divider(color: Colors.grey),
            itemBuilder: (_, index) => CategoryItem(categoryList[index]),
          );
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryList categoryList;

  const CategoryItem(this.categoryList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(categoryList.group.label),
        ),
        GridView.count(
          padding: const EdgeInsets.symmetric(vertical: 10),
          childAspectRatio: 80 / 24,
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          primary: false,
          children: _buildClips(categoryList.children, context),
        )
      ],
    );
  }

  List<Widget> _buildClips(List<CategoryInfo> children, BuildContext context) {
    return children.map((item) {
      return ActionChip(
        label: Container(
          alignment: Alignment.center,
          height: 24,
          width: 80,
          child: Tooltip(
            message: item.label,
            child: Text(
              item.label,
              style: const TextStyle(fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        onPressed: () => context.goto(CategoryListScreen(item)),
      );
    }).toList();
  }
}
