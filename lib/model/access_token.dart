import 'package:json_annotation/json_annotation.dart';

part 'access_token.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class AccessToken {
  final String tokenType;
  final String accessToken;
  final String? refreshToken;
  final int expiresIn;

  AccessToken({
    required this.tokenType,
    required this.accessToken,
    this.refreshToken,
    required this.expiresIn,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) => _$AccessTokenFromJson(json);
}
