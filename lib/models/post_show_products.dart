import 'package:padimall_app/models/post_show_suppliers_agent_detail.dart';

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
    this.agent,
    this.images,
    this.ratingSummary,
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
  Agent agent;
  List<ImageProduct> images;
  RatingSummary ratingSummary;

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
        agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
        images: json["image"] == null ? [] : List<ImageProduct>.from(json["image"].map((x) => ImageProduct.fromJson(x))),
        ratingSummary: json["rating_summary"] == null ? null : RatingSummary.fromJson(json["rating_summary"]),
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
        "agent": agent == null ? null : agent.toJson(),
        "image": images == null ? null : List<dynamic>.from(images.map((x) => x.toJson())),
        "rating_summary": ratingSummary == null ? null : ratingSummary.toJson(),
      };
}

class ImageProduct {
  ImageProduct({
    this.id,
    this.url,
  });

  String id;
  String url;

  factory ImageProduct.fromJson(Map<String, dynamic> json) => ImageProduct(
        id: json["id"] == null ? null : json["id"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "url": url == null ? null : url,
      };
}

class RatingSummary {
  RatingSummary({
    this.averageStar,
    this.totalRatings,
    this.sample,
  });

  double averageStar;
  int totalRatings;
  RatingProduct sample;

  factory RatingSummary.fromJson(Map<String, dynamic> json) => RatingSummary(
        averageStar: json["average_star"] == null ? null : json["average_star"].toDouble(),
        totalRatings: json["total_ratings"] == null ? null : json["total_ratings"],
        sample: json["sample"] == null ? null : RatingProduct.fromJson(json["sample"]),
      );

  Map<String, dynamic> toJson() => {
        "average_star": averageStar == null ? null : averageStar,
        "total_ratings": totalRatings == null ? null : totalRatings,
        "sample": sample == null ? null : sample.toJson(),
      };
}

class RatingProduct {
  RatingProduct({
    this.id,
    this.name,
    this.star,
    this.description,
    this.showName,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  String id;
  String name;
  int star;
  String description;
  int showName;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> images;

  factory RatingProduct.fromJson(Map<String, dynamic> json) => RatingProduct(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    star: json["star"] == null ? null : json["star"],
    description: json["description"] == null ? null : json["description"],
    showName: json["show_name"] == null ? null : json["show_name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    images: json["images"] == null ? null : List<dynamic>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "star": star == null ? null : star,
    "description": description == null ? null : description,
    "show_name": showName == null ? null : showName,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "images": images == null ? null : List<dynamic>.from(images.map((x) => x)),
  };
}
