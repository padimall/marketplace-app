class PostRestSuppliersAgentDetail {
  PostRestSuppliersAgentDetail({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Agent data;

  factory PostRestSuppliersAgentDetail.fromJson(Map<String, dynamic> json) => PostRestSuppliersAgentDetail(
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
    this.createdAt,
    this.updatedAt,
    this.agentCode,
  });

  String id;
  String userId;
  String name;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;
  String agentCode;

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    name: json["name"] == null ? null : json["name"],
    phone: json["phone"] == null ? null : json["phone"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    agentCode: json["agent_code"] == null ? null : json["agent_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "name": name == null ? null : name,
    "phone": phone == null ? null : phone,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "agent_code": agentCode == null ? null : agentCode,
  };
}