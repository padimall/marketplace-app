import 'package:padimall_app/models/order.dart';
import 'package:padimall_app/models/post_show_suppliers_agent_detail.dart';

class PostResShowUserCart {
  PostResShowUserCart({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Cart> data;

  factory PostResShowUserCart.fromJson(Map<String, dynamic> json) => PostResShowUserCart(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<Cart>.from(json["data"].map((x) => Cart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Cart {
  Cart({
    this.agent,
    this.orders,
  });

  Agent agent;
  List<Order> orders;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
        orders: json["orders"] == null ? null : List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "agent": agent == null ? null : agent.toJson(),
        "orders": orders == null ? null : List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}
