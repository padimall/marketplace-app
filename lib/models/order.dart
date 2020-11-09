class Order {
  Order({
    this.cartId,
    this.productId,
    this.name,
    this.price,
    this.quantity,
    this.stock,
    this.minOrder,
  });

  String cartId;
  String productId;
  String name;
  int price;
  int quantity;
  int stock;
  int minOrder;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    cartId: json["cart_id"] == null ? null : json["cart_id"],
    productId: json["product_id"] == null ? null : json["product_id"],
    name: json["name"] == null ? null : json["name"],
    price: json["price"] == null ? null : json["price"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    stock: json["stock"] == null ? null : json["stock"],
    minOrder: json["min_order"] == null ? null : json["min_order"],
  );

  Map<String, dynamic> toJson() => {
    "cart_id": cartId == null ? null : cartId,
    "product_id": productId == null ? null : productId,
    "name": name == null ? null : name,
    "price": price == null ? null : price,
    "quantity": quantity == null ? null : quantity,
    "stock": stock == null ? null : stock,
    "min_order": minOrder == null ? null : minOrder,
  };
}