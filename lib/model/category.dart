class CategoryList {
  final CategoryInfo group;
  final List<CategoryInfo> children;

  const CategoryList({required this.group, required this.children});
}

class CategoryInfo {
  final String url;
  final String label;

  const CategoryInfo({required this.url, required this.label});
}
