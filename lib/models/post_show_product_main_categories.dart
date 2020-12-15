import 'package:padimall_app/models/product_main_category.dart';

class PostResMainCategories {
  PostResMainCategories({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<ProductMainCategory> data;

  factory PostResMainCategories.fromJson(Map<String, dynamic> json) => PostResMainCategories(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<ProductMainCategory>.from(json["data"].map((x) => ProductMainCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
