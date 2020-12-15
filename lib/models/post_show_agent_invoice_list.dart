import 'package:padimall_app/models/post_show_user_invoice_list.dart';

class PostResAgentInvoiceList {
  PostResAgentInvoiceList({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<InvoiceSummary> data;

  factory PostResAgentInvoiceList.fromJson(Map<String, dynamic> json) => PostResAgentInvoiceList(
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