import 'package:padimall_app/models/post_show_products.dart';

class PostResShowProductDetail {
  PostResShowProductDetail({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Product data;

  factory PostResShowProductDetail.fromJson(Map<String, dynamic> json) => PostResShowProductDetail(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Product.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
}