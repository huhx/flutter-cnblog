import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthRequest {
  static const String authorizeUrl = "https://oauth.cnblogs.com/connect/authorize";
  static const String callbackUrl = "https://oauth.cnblogs.com/auth/callback";
  static final String clientId = dotenv.env['clientId']!;
  final String clientSecret = dotenv.env['clientSecret']!;

  static String getAuthorizeUrl() {
    final Map<String, String> parameters = {
      "client_id": clientId,
      "scope": "openid profile CnBlogsApi offline_access",
      "response_type": "code id_token",
      "redirect_uri": callbackUrl,
      "state": "cnblog",
      "nonce": DateTime.now().toString(),
    };
    return Uri(scheme: "https", host: "oauth.cnblogs.com", path: "connect/authorize", queryParameters: parameters).toString();
  }

  static String getCodeFromUrl(String url) {
    return url.split("&")[0].split("=")[1];
  }

  static String encodeMap(Map<String, String> data) {
    return data.keys.map((key) => "$key=${Uri.encodeComponent(data[key]!)}").join("&");
  }
}
