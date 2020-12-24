import 'package:padimall_app/models/order.dart';
import 'package:padimall_app/models/post_show_suppliers_agent_detail.dart';
import 'package:padimall_app/models/post_show_user_cart.dart';
import 'package:padimall_app/models/post_show_user_profile.dart';

class PostResCheckoutInfo {
  PostResCheckoutInfo({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  CheckoutDetail data;

  factory PostResCheckoutInfo.fromJson(Map<String, dynamic> json) => PostResCheckoutInfo(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : CheckoutDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
}

class CheckoutDetail {
  CheckoutDetail({
    this.user,
    this.payments,
    this.logistics,
    this.checkouts,
  });

  UserProfileDetail user;
  List<Payment> payments;
  List<Logistic> logistics;
  List<CheckoutPerAgent> checkouts;

  factory CheckoutDetail.fromJson(Map<String, dynamic> json) => CheckoutDetail(
    user: json["user"] == null ? null : UserProfileDetail.fromJson(json["user"]),
    payments: json["payments"] == null ? null : List<Payment>.from(json["payments"].map((x) => Payment.fromJson(x))),
    logistics: json["logistics"] == null ? null : List<Logistic>.from(json["logistics"].map((x) => Logistic.fromJson(x))),
    checkouts: json["checkouts"] == null ? null : List<CheckoutPerAgent>.from(json["checkouts"].map((x) => CheckoutPerAgent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user == null ? null : user.toJson(),
    "payments": payments == null ? null : List<dynamic>.from(payments.map((x) => x.toJson())),
    "logistics": logistics == null ? null : List<dynamic>.from(logistics.map((x) => x.toJson())),
    "checkouts": checkouts == null ? null : List<dynamic>.from(checkouts.map((x) => x.toJson())),
  };
}

class CheckoutPerAgent {
  CheckoutPerAgent({
    this.agent,
    this.orders,
    this.subtotal,
    this.logistic,
  });

  Agent agent;
  int subtotal;
  Logistic logistic;
  List<Order> orders;

  factory CheckoutPerAgent.fromJson(Map<String, dynamic> json) => CheckoutPerAgent(
    agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
    orders: json["orders"] == null ? null : List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
    subtotal: 0,
    logistic: null,
  );

  Map<String, dynamic> toJson() => {
    "agent": agent == null ? null : agent.toJson(),
    "orders": orders == null ? null : List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}

class Logistic {
  Logistic({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory Logistic.fromJson(Map<String, dynamic> json) => Logistic(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}

class Payment {
  Payment({
    this.type,
    this.methods,
  });

  String type;
  List<PaymentMethod> methods;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    type: json["method"] == null ? null : json["method"],
    methods: json["method_codes"] == null ? null : List<PaymentMethod>.from(json["method_codes"].map((x) => PaymentMethod.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "method": type == null ? null : type,
    "method_codes": methods == null ? null : List<dynamic>.from(methods.map((x) => x.toJson())),
  };
}

class PaymentMethod {
  PaymentMethod({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}

// class Payment {
//   Payment({
//     this.id,
//     this.gate,
//     this.method,
//     this.methodCode,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   String id;
//   String gate;
//   String method;
//   String methodCode;
//   int status;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory Payment.fromJson(Map<String, dynamic> json) => Payment(
//     id: json["id"] == null ? null : json["id"],
//     gate: json["gate"] == null ? null : json["gate"],
//     method: json["method"] == null ? null : json["method"],
//     methodCode: json["method_code"] == null ? null : json["method_code"],
//     status: json["status"] == null ? null : json["status"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "gate": gate == null ? null : gate,
//     "method": method == null ? null : method,
//     "method_code": methodCode == null ? null : methodCode,
//     "status": status == null ? null : status,
//     "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//     "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//   };
// }