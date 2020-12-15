class PostShowBanner {
  PostShowBanner({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<NewsBanner> data;

  factory PostShowBanner.fromJson(Map<String, dynamic> json) => PostShowBanner(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<NewsBanner>.from(json["data"].map((x) => NewsBanner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NewsBanner {
  NewsBanner({
    this.id,
    this.image,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String image;
  String type;
  DateTime createdAt;
  DateTime updatedAt;

  factory NewsBanner.fromJson(Map<String, dynamic> json) => NewsBanner(
    id: json["id"] == null ? null : json["id"],
    image: json["image"] == null ? null : json["image"],
    type: json["type"] == null ? null : json["type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "image": image == null ? null : image,
    "type": type == null ? null : type,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}