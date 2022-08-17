import 'package:flutter_cnblog/common/extension/string_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should delete first and last quotation", () {
    expect('"Hello'.trimQuotation(), "Hello", reason: "start with quotation");
    expect('"Hello"'.trimQuotation(), "Hello", reason: "start and end with quotation");
    expect('Hel"lo'.trimQuotation(), "Hel\"lo", reason: "neither start nor end with quotation");
  });
}
