class PostResLoginDev {
  PostResLoginDev({
    this.accessToken,
    this.tokenType,
    this.expiresAt,
  });

  String accessToken;
  String tokenType;
  DateTime expiresAt;

  factory PostResLoginDev.fromJson(Map<String, dynamic> json) => PostResLoginDev(
    accessToken: json["access_token"] == null ? null : json["access_token"],
    tokenType: json["token_type"] == null ? null : json["token_type"],
    expiresAt: json["expires_at"] == null ? null : DateTime.parse(json["expires_at"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken == null ? null : accessToken,
    "token_type": tokenType == null ? null : tokenType,
    "expires_at": expiresAt == null ? null : expiresAt.toIso8601String(),
  };
}