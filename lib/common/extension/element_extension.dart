import 'package:flutter_cnblog/common/extension/list_extension.dart';
import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:html/dom.dart';

extension ElementExtension on Element {
  String getText() {
    return firstChild!.toString().trimQuotation();
  }

  int getIntValue() {
    return getText().toInt();
  }

  String getFirstChildText() {
    return children.first.getText();
  }

  String getLastChildText() {
    return children.last.getText();
  }

  bool hasAttributeValue(String attributeName, String value) {
    return attributes[attributeName] == value;
  }

  String? getAttributeValue(String attributeName) {
    return attributes[attributeName];
  }

  String getFirstNodeText() {
    return nodes.first.toString().trimQuotation().trim();
  }

  String getLastNodeText() {
    return nodes.last.toString().trimQuotation().trim();
  }

  String getParentLastNodeText() {
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
