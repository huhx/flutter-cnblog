import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'clientId', obfuscate: true)
  static final String clientId = _Env.clientId;

  @EnviedField(varName: 'clientSecret', obfuscate: true)
  static final String clientSecret = _Env.clientSecret;

  @EnviedField(varName: 'notRobotCookie', obfuscate: true)
  static final String notRobotCookie = _Env.notRobotCookie;
}
