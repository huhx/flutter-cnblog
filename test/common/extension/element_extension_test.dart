import 'package:flutter_cnblog/common/extension/element_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';

void main() {
  test("get text from element", () {
    const String string = '''
    <div class="clear">Hello World</div>
    ''';
    final Element element = Element.html(string);

    final String result = element.getText();

    expect(result, "Hello World");
  });

  test("get text from first children element", () {
    const String string = '''
      <div class="dayTitle">
        <a href="https://www.cnblogs.com/huhx/archive/2022/08/06.html">2022年8月6日</a>
      </div>
    ''';
    final Element element = Element.html(string);

    final String result = element.getFirstChildText();

    expect(result, "2022年8月6日");
  });

  test("get text from last children element", () {
    const String string = '''
      <div class="dayTitle">
        <a href="https://www.cnblogs.com/huhx/archive/2022/08/06.html">2022年8月6日</a>
        <span>span text</span>
      </div>
    ''';
    final Element element = Element.html(string);

    final String result = element.getLastChildText();

    expect(result, "span text");
  });

  test("get text from last nodes", () {
    const String string = '''
      <div class="dayTitle">
        <a href="https://www.cnblogs.com/huhx/archive/2022/08/06.html">2022年8月6日</a>
        <span>span text</span>
        Hello World.
      </div>
    ''';
    final Element element = Element.html(string);

    final String result = element.getLastNodeText();

    expect(result, "Hello World.");
  });

  test("get value by attribute name", () {
    const String string = '''
      <div class="dayTitle">
        <a href="https://www.cnblogs.com/huhx/archive/2022/08/06.html">2022年8月6日</a>
        <span>span text</span>
        Hello World.
      </div>
    ''';
    final Element element = Element.html(string);

    final String result = element.getAttributeValue("class")!;

    expect(result, "dayTitle");
  });
}
