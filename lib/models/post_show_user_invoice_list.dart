class PostResUserInvoiceList {
  PostResUserInvoiceList({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<InvoiceSummary> data;

  factory PostResUserInvoiceList.fromJson(Map<String, dynamic> json) => PostResUserInvoiceList(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<InvoiceSummary>.from(json["data"].map((x) => InvoiceSummary.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class InvoiceSummary {
  InvoiceSummary({
    this.id,
    this.userId,
    this.supplierId,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.agentId,
    this.invoicesGroupId,
  });

  String id;
  String userId;
  String supplierId;
  int amount;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String agentId;
  String invoicesGroupId;

  factory InvoiceSummary.fromJson(Map<String, dynamic> json) => InvoiceSummary(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
    amount: json["amount"] == null ? null : json["amount"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    agentId: json["agent_id"] == null ? null : json["agent_id"],
    invoicesGroupId: json["invoices_group_id"] == null ? null : json["invoices_group_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "supplier_id": supplierId == null ? null : supplierId,
    "amount": amount == null ? null : amount,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "agent_id": agentId == null ? null : agentId,
    "invoices_group_id": invoicesGroupId == null ? null : invoicesGroupId,
  };
}
