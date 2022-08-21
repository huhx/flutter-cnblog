import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should delete first and last quotation", () {
    expect('"Hello'.trimQuotation(), "Hello", reason: "start with quotation");
    expect('"Hello"'.trimQuotation(), "Hello", reason: "start and end with quotation");
    expect('Hel"lo'.trimQuotation(), "Hel\"lo", reason: "neither start nor end with quotation");
  });

  test("should return int when call toInt method", () {
    expect('Hello'.toInt(defaultValue: 0), 0, reason: "because can not parse 'Hello' to int");
    expect('12'.toInt(defaultValue: 0), 12, reason: "can parse '12' to int, ignore default value");
    expect('13'.toInt(), 13, reason: "can parse '13' to int");
  });
}
