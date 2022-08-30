import 'package:equatable/equatable.dart';

class BlogShare extends Equatable {
  final int? id;
  final String title;
  final String url;
  final String? name;

  const BlogShare({
    this.id,
    required this.title,
    required this.url,
    this.name,
  });

  @override
  List<Object?> get props => [id, title, url, name];
}

class BlogShareSetting extends Equatable {
  final bool isMark;
  final bool isDarkMode;

  const BlogShareSetting({required this.isMark, required this.isDarkMode});

  @override
  List<Object?> get props => [isMark, isDarkMode];
}
