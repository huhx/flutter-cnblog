import 'package:equatable/equatable.dart';

class CategoryList extends Equatable {
  final CategoryInfo group;
  final List<CategoryInfo> children;

  const CategoryList({required this.group, required this.children});

  @override
  List<Object?> get props => [group, children];
}

class CategoryInfo extends Equatable {
  final String url;
  final String label;

  const CategoryInfo({required this.url, required this.label});

  @override
  List<Object?> get props => [url, label];
}
