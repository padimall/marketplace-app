class PostResShowProductCategories {
  PostResShowProductCategories({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<ProductCategory> data;

  factory PostResShowProductCategories.fromJson(Map<String, dynamic> json) => PostResShowProductCategories(
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

class ProductCategory {
  ProductCategory({
    this.id,
    this.name,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String name;
  String image;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}