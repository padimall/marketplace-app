import 'package:padimall_app/models/post_show_checkout_info.dart';
import 'package:padimall_app/models/post_show_user_invoice_list.dart';
import 'package:padimall_app/models/post_show_user_profile.dart';

class PostResShowInvoiceDetail {
  PostResShowInvoiceDetail({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  InvoiceDetail data;

  factory PostResShowInvoiceDetail.fromJson(Map<String, dynamic> json) => PostResShowInvoiceDetail(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : InvoiceDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
}

class InvoiceDetail {
  InvoiceDetail({
    this.id,
    this.userId,
    this.supplierId,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.agentId,
    this.agentName,
    this.invoicesGroupId,
    this.image,
    this.user,
    this.logistic,
    this.payment,
    this.products,
  });

  String id;
  String userId;
  String supplierId;
  int amount;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String agentId;
  String agentName;
  String invoicesGroupId;
  dynamic image;
  UserProfileDetail user;
  Logistic logistic;
  Payment payment;
  List<ProductInvoice> products;

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) => InvoiceDetail(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
    amount: json["amount"] == null ? null : json["amount"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    agentId: json["agent_id"] == null ? null : json["agent_id"],
    agentName: json["agent_name"] == null ? null : json["agent_name"],
    invoicesGroupId: json["invoices_group_id"] == null ? null : json["invoices_group_id"],
    image: json["image"] == null ? null : json["image"],
    user: json["user"] == null ? null : UserProfileDetail.fromJson(json["user"]),
    logistic: json["logistic"] == null ? null : Logistic.fromJson(json["logistic"]),
    payment: json["payment"] == null ? null : Payment.fromJson(json["payment"]),
    products: json["products"] == null ? null : List<ProductInvoice>.from(json["products"].map((x) => ProductInvoice.fromJson(x))),
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
    "image": image,
    "user": user == null ? null : user.toJson(),
    "logistic": logistic == null ? null : logistic.toJson(),
    "payment": payment == null ? null : payment.toJson(),
    "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toJson())),
  };
}