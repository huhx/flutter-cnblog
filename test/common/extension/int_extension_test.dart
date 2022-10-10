import 'package:flutter_cnblog/common/extension/int_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return date string with default date format", () {
    expect(1665387694740.toDateString(), "2022-10-10");
  });

  test("should return date string with given date format", () {
    expect(1665387694740.toDateString(dateFormat: "dd/MM/yyyy"), "10/10/2022");
  });
}
