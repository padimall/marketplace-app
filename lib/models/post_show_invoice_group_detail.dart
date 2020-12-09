import 'package:padimall_app/models/post_show_checkout_info.dart';
import 'package:padimall_app/models/post_show_invoice_detail.dart';
import 'package:padimall_app/models/post_show_user_profile.dart';

class PostResInvoiceGroupDetail {
  PostResInvoiceGroupDetail({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  InvoiceGroupDetail data;

  factory PostResInvoiceGroupDetail.fromJson(Map<String, dynamic> json) => PostResInvoiceGroupDetail(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : InvoiceGroupDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
}

class InvoiceGroupDetail {
  InvoiceGroupDetail({
    this.id,
    this.amount,
    this.externalPaymentId,
    this.paymentId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.payment,
    this.user,
    this.invoices,
  });

  String id;
  int amount;
  String externalPaymentId;
  String paymentId;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;
  Payment payment;
  UserProfileDetail user;
  List<InvoiceDetail> invoices;

  factory InvoiceGroupDetail.fromJson(Map<String, dynamic> json) => InvoiceGroupDetail(
    id: json["id"] == null ? null : json["id"],
    amount: json["amount"] == null ? null : json["amount"],
    externalPaymentId: json["external_payment_id"] == null ? null : json["external_payment_id"],
    paymentId: json["payment_id"] == null ? null : json["payment_id"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    userId: json["user_id"] == null ? null : json["user_id"],
    payment: json["payment"] == null ? null : Payment.fromJson(json["payment"]),
    user: json["user"] == null ? null : UserProfileDetail.fromJson(json["user"]),
    invoices: json["invoices"] == null ? null : List<InvoiceDetail>.from(json["invoices"].map((x) => InvoiceDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "amount": amount == null ? null : amount,
    "external_payment_id": externalPaymentId == null ? null : externalPaymentId,
    "payment_id": paymentId == null ? null : paymentId,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "user_id": userId == null ? null : userId,
    "payment": payment == null ? null : payment.toJson(),
    "user": user == null ? null : user.toJson(),
    "invoices": invoices == null ? null : List<dynamic>.from(invoices.map((x) => x.toJson())),
  };
}