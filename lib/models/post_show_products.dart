class PostResShowProducts {
  PostResShowProducts({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Product> data;

  factory PostResShowProducts.fromJson(Map<String, dynamic> json) => PostResShowProducts(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.id,
    this.supplierId,
    this.name,
    this.price,
    this.weight,
    this.description,
    this.category,
    this.stock,
    this.status,
    this.minOrder,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  String id;
  String supplierId;
  String name;
  int price;
  int weight;
  String description;
  String category;
  int stock;
  String status;
  int minOrder;
  DateTime createdAt;
  DateTime updatedAt;
  List images;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] == null ? null : json["id"],
    supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
    name: json["name"] == null ? null : json["name"],
    price: json["price"] == null ? null : json["price"],
    weight: json["weight"] == null ? null : json["weight"],
    description: json["description"] == null ? null : json["description"],
    category: json["category"] == null ? null : json["category"],
    stock: json["stock"] == null ? null : json["stock"],
    status: json["status"] == null ? null : json["status"],
    minOrder: json["min_order"] == null ? null : json["min_order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    images: json["image"] == null ? null : List<dynamic>.from(json["image"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "supplier_id": supplierId == null ? null : supplierId,
    "name": name == null ? null : name,
    "price": price == null ? null : price,
    "weight": weight == null ? null : weight,
    "description": description == null ? null : description,
    "category": category == null ? null : category,
    "stock": stock == null ? null : stock,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "image": images == null ? null : List<dynamic>.from(images.map((x) => x)),
  };
}