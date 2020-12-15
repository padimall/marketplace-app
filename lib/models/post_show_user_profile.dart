class UserProfileDetail {
  UserProfileDetail({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.address,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String address;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserProfileDetail.fromJson(Map<String, dynamic> json) => UserProfileDetail(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    emailVerifiedAt: json["email_verified_at"],
    address: json["address"] == null ? null : json["address"],
    phone: json["phone"] == null ? null : json["phone"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "email_verified_at": emailVerifiedAt,
    "address": address == null ? null : address,
    "phone": phone == null ? null : phone,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}