import 'package:flutter_cnblog/common/parser/category_parser.dart';
import 'package:html/dom.dart';

extension ElementExtension on Element {
  String getText() {
    return firstChild!.toString().trimQuotation();
  }

  String getFirstChildText() {
    return children.first.getText();
  }

  String getLastChildText() {
    return children.last.getText();
  }

  String? getAttributeValue(String attributeName) {
    return attributes[attributeName];
  }

  String getLastNodeText() {
    return nodes.last.toString().trimQuotation().trim();
  }

  Element getFirstByClass(String name) {
    return getElementsByClassName(name).first;
  }

  Element getFirstByTag(String name) {
    return getElementsByTagName(name).first;
  }
}
