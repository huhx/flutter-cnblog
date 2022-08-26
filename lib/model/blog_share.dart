import 'package:equatable/equatable.dart';

class BlogShare extends Equatable {
  final int id;
  final String title;
  final String url;
  final String name;

  const BlogShare({
    required this.id,
    required this.title,
    required this.url,
    required this.name,
  });

  @override
  List<Object?> get props => [id, title, url, name];
}
