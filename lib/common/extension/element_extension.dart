import 'package:app_common_flutter/extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:html/dom.dart';

extension ElementExtension on Element {
  String get content {
    return firstChild!.toString().trimQuotation();
  }

  int get intContent {
    return content.toInt();
  }

  String get firstChildText {
    return children.first.content;
  }

  String get lastChildText {
    return children.last.content;
  }

  bool hasAttributeValue(String attributeName, String value) {
    return attributes[attributeName] == value;
  }

  String? getAttributeValue(String attributeName) {
    return attributes[attributeName];
  }

  String get firstNodeText {
    return nodes.first.toString().trimQuotation().trim();
  }

  String get lastNodeText {
    return nodes.last.toString().trimQuotation().trim();
  }

  String get parentLastNodeText {
    return parentNode!.nodes.last.toString().trimQuotation().trim();
  }

  Element getFirstByClass(String name) {
    return getElementsByClassName(name).first;
  }

  Element? getFirstOrNullByClass(String name) {
    return getElementsByClassName(name).firstOrNull;
  }

  Element getFirstByTag(String name) {
    return getElementsByTagName(name).first;
  }

  Element? getFirstOrNullByTag(String name) {
    return getElementsByTagName(name).firstOrNull;
  }

  Element getLastByClass(String name) {
    return getElementsByClassName(name).last;
  }

  Element getLastByTag(String name) {
    return getElementsByTagName(name).last;
  }

  String getRegexText(String pattern, {int group = 1}) {
    return RegExp(pattern).firstMatch(innerHtml)!.group(group)!;
  }
}
