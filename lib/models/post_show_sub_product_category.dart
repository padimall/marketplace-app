import 'package:padimall_app/models/post_show_product_categories.dart';

class PostResProductSubCategories {
  PostResProductSubCategories({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<ProductCategory> data;

  factory PostResProductSubCategories.fromJson(Map<String, dynamic> json) => PostResProductSubCategories(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<ProductCategory>.from(json["data"].map((x) => ProductCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}