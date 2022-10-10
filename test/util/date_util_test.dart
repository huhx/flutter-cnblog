import 'package:flutter_cnblog/util/date_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("get week string from date time", () {
    final String result = DateUtil.getWeekFromDate(DateTime(2022, 10, 10));

    expect(result, "星期一");
  });

  test("get week string from date string", () {
    final String result = DateUtil.getWeekFromString("2022-10-10");

    expect(result, "星期一");
  });
}
