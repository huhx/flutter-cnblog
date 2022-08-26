import 'package:equatable/equatable.dart';

class HtmlCss extends Equatable {
  final String html;
  final String css;
  final String host;

  const HtmlCss({required this.html, required this.css, required this.host});

  @override
  List<Object?> get props => [html, css, host];
}
