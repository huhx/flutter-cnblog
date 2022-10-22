import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthRequest {
  static const String callbackUrl = "https://oauth.cnblogs.com/auth/callback";

  static Uri get authorizeUri {
    final Map<String, String> parameters = {
      "client_id": dotenv.env['clientId']!,
      "scope": "openid profile CnBlogsApi offline_access",
      "response_type": "code id_token",
      "redirect_uri": callbackUrl,
      "state": "cnblog",
      "nonce": DateTime.now().millisecondsSinceEpoch.toString(),
    };
    return Uri(scheme: "https", host: "oauth.cnblogs.com", path: "connect/authorize", queryParameters: parameters);
  }

  static String getCodeFromUrl(String url) {
    return url.split("&")[0].split("=")[1];
  }
}
