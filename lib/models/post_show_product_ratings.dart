import 'package:padimall_app/models/post_show_products.dart';

class PostResProductRatings {
  PostResProductRatings({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<RatingProduct> data;

  factory PostResProductRatings.fromJson(Map<String, dynamic> json) => PostResProductRatings(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<RatingProduct>.from(json["data"].map((x) => RatingProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}