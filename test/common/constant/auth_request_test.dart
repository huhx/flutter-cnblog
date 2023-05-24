import 'package:flutter_cnblog/common/constant/auth_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("get authorization code from url", () {
    const String url =
        "https://oauth.cnblogs.com/auth/callback#code=D3A104A979E6221C7C45E8CA&id_token=eyJhbGciOiJSUzI1NiIsImtpZCI6";

    final String result = AuthRequest.getCodeFromUrl(url);

    expect(result, "D3A104A979E6221C7C45E8CA");
  });
}
