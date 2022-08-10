import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constant {
  final String authorizeUrl =
      "https://oauth.cnblogs.com/connect/authorize?client_id=${dotenv.env['clientId']}&scope=openid%20profile%20CnBlogsApi%20offline_access&response_type=code%20id_token&redirect_uri=https://oauth.cnblogs.com/auth/callback&state=abc&nonce=${DateTime.now().microsecondsSinceEpoch}";
}
