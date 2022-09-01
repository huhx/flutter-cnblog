import 'package:flutter_cnblog/common/support/comm_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("get blog name from blog url", () {
    const String url = "https://www.cnblogs.com/huhx/p/16556548.html";

    final String result = Comm.getNameFromBlogUrl(url);

    expect(result, "huhx");
  });
}
