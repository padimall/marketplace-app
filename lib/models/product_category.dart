class ProductCategory {
  ProductCategory({
    this.id,
    this.name,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.mainCategoryId,
  });

  String id;
  String name;
  String image;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String mainCategoryId;

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    mainCategoryId: json["main_category_id"] == null ? null : json["main_category_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "main_category_id": mainCategoryId == null ? null : mainCategoryId,
  };
}