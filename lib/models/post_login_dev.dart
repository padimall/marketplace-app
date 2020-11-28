class PostResLogin {
  PostResLogin({
    this.accessToken,
    this.tokenType,
    this.message,
    this.expiresAt,
  });

  String accessToken;
  String tokenType;
  String message;
  DateTime expiresAt;

  factory PostResLogin.fromJson(Map<String, dynamic> json) => PostResLogin(
    accessToken: json["access_token"] == null ? null : json["access_token"],
    tokenType: json["token_type"] == null ? null : json["token_type"],
    message: json["message"] == null ? null : json["message"],
    expiresAt: json["expires_at"] == null ? null : DateTime.parse(json["expires_at"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken == null ? null : accessToken,
    "token_type": tokenType == null ? null : tokenType,
    "message": message == null ? null : message,
    "expires_at": expiresAt == null ? null : expiresAt.toIso8601String(),
  };
}