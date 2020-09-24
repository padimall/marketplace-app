class PostResShowSupplierDetail {
  PostResShowSupplierDetail({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  SupplierDetail data;

  factory PostResShowSupplierDetail.fromJson(Map<String, dynamic> json) => PostResShowSupplierDetail(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : SupplierDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
}

class SupplierDetail {
  SupplierDetail({
    this.id,
    this.userId,
    this.name,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.nib,
  });

  String id;
  String userId;
  String name;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;
  String nib;

  factory SupplierDetail.fromJson(Map<String, dynamic> json) => SupplierDetail(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    name: json["name"] == null ? null : json["name"],
    phone: json["phone"] == null ? null : json["phone"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    nib: json["nib"] == null ? null : json["nib"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "name": name == null ? null : name,
    "phone": phone == null ? null : phone,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "nib": nib == null ? null : nib,
  };
}