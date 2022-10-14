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

  test("get int value from element", () {
    const String string = '''
    <div class="digg">33</div>
    ''';
    final Element element = Element.html(string);

    final int result = element.getIntValue();

    expect(result, 33);
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

  test("get bool whether element contain attribute with the provided value", () {
    const String string = '''
      <div class="dayTitle">
        <a href="https://www.cnblogs.com/huhx/archive/2022/08/06.html">2022年8月6日</a>
        <span>span text</span>
      </div>
    ''';
    final Element element = Element.html(string);

    final bool hasClassValue1 = element.hasAttributeValue("class", "dayTitle");
    final bool hasClassValue2 = element.hasAttributeValue("class", "dayTitle1");
    final bool hasClassValue3 = element.hasAttributeValue("id", "dayTitle");

    expect(hasClassValue1, true);
    expect(hasClassValue2, false);
    expect(hasClassValue3, false);
  });

  test("get text from first nodes", () {
    const String string = '''
      <div class="dayTitle">
         World Hello.
        <a href="https://www.cnblogs.com/huhx/archive/2022/08/06.html">2022年8月6日</a>
        <span>span text</span>
        Hello World.
      </div>
    ''';
    final Element element = Element.html(string);

    final String result = element.getFirstNodeText();

    expect(result, "World Hello.");
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

  test("get text from parent last nodes", () {
    const String string = '''
      <span><i class="iconfont icon-dianzan" aria-hidden="true"></i>18</span>
    ''';
    final Element element = Element.html(string);
    final Element spanElement = element.getFirstByClass("icon-dianzan");

    final String result = spanElement.getParentLastNodeText();

    expect(result, "18");
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

  test("return null when getFirstOrNullByClass given no elements", () {
    const String string = '''
      <span><i class="iconfont icon-dianzan" aria-hidden="true"></i>18</span>
    ''';
    final Element element = Element.html(string);

    final Element? viewElement = element.getFirstOrNullByClass("icon-view");

    expect(viewElement, null);
  });

  test("return null when getFirstOrNullByTag given no elements", () {
    const String string = '''
      <span><i class="iconfont icon-dianzan" aria-hidden="true"></i>18</span>
    ''';
    final Element element = Element.html(string);

    final Element? divElement = element.getFirstOrNullByTag("div");

    expect(divElement, null);
  });

  test("get text with pattern from text", () {
    const String string = '''
     <span data-post-id="16685636" class="post-view-count">阅读(442)</span> 
    ''';
    final Element element = Element.html(string);

    final String viewCount = element.getRegexText(r"阅读\(([0-9]+)\)");

    expect(viewCount, "442");
  });
}
