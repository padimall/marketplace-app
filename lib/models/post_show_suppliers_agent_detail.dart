import 'package:padimall_app/models/post_show_supplier_detail.dart';

class PostResSuppliersAgentDetail {
  PostResSuppliersAgentDetail({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Agent data;

  factory PostResSuppliersAgentDetail.fromJson(Map<String, dynamic> json) => PostResSuppliersAgentDetail(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Agent.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
}

class Agent {
  Agent({
    this.id,
    this.userId,
    this.name,
    this.phone,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.agentCode,
    this.imageUrl,
    this.status,
    this.suppliers
  });

  String id;
  String userId;
  String name;
  String address;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;
  String agentCode;
  String imageUrl;
  int status;
  List<Supplier> suppliers;

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    phone: json["phone"] == null ? null : json["phone"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    agentCode: json["agent_code"] == null ? null : json["agent_code"],
    imageUrl: json["image"] == null ? null : json["image"],
    status: json["status"] == null ? null : json["status"],
    suppliers: json["supplier"] == null ? null : List<Supplier>.from(json["supplier"].map((x) => Supplier.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "name": name == null ? null : name,
    "address": address == null ? null : address,
    "phone": phone == null ? null : phone,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "agent_code": agentCode == null ? null : agentCode,
  };
}