class PostResUserInvoiceList {
  PostResUserInvoiceList({
    this.status,
    this.message,
    this.invoiceGroups,
  });

  int status;
  String message;
  List<InvoiceGroup> invoiceGroups;

  factory PostResUserInvoiceList.fromJson(Map<String, dynamic> json) => PostResUserInvoiceList(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    invoiceGroups: json["invoice_groups"] == null ? null : List<InvoiceGroup>.from(json["invoice_groups"].map((x) => InvoiceGroup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "invoice_groups": invoiceGroups == null ? null : List<dynamic>.from(invoiceGroups.map((x) => x.toJson())),
  };
}

class InvoiceGroup {
  InvoiceGroup({
    this.id,
    this.amount,
    this.externalPaymentId,
    this.paymentId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.invoices,
  });

  String id;
  int amount;
  String externalPaymentId;
  String paymentId;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;
  List<InvoiceSummary> invoices;

  factory InvoiceGroup.fromJson(Map<String, dynamic> json) => InvoiceGroup(
    id: json["id"] == null ? null : json["id"],
    amount: json["amount"] == null ? null : json["amount"],
    externalPaymentId: json["external_payment_id"] == null ? null : json["external_payment_id"],
    paymentId: json["payment_id"] == null ? null : json["payment_id"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    userId: json["user_id"] == null ? null : json["user_id"],
    invoices: json["invoices"] == null ? null : List<InvoiceSummary>.from(json["invoices"].map((x) => InvoiceSummary.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "amount": amount == null ? null : amount,
    "external_payment_id": externalPaymentId == null ? null : externalPaymentId,
    "payment_id": paymentId == null ? null : paymentId,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "user_id": userId == null ? null : userId,
    "invoices": invoices == null ? null : List<dynamic>.from(invoices.map((x) => x.toJson())),
  };
}

class InvoiceSummary {
  InvoiceSummary({
    this.id,
    this.userId,
    this.supplierId,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.agentId,
    this.agentName,
    this.invoicesGroupId,
    this.image,
    this.products,
  });

  String id;
  String userId;
  String supplierId;
  int amount;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String agentId;
  String agentName;
  String invoicesGroupId;
  String image;
  List<ProductInvoice> products;

  factory InvoiceSummary.fromJson(Map<String, dynamic> json) => InvoiceSummary(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
    amount: json["amount"] == null ? null : json["amount"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    agentId: json["agent_id"] == null ? null : json["agent_id"],
    agentName: json["agent_name"] == null ? null : json["agent_name"],
    invoicesGroupId: json["invoices_group_id"] == null ? null : json["invoices_group_id"],
    image: json["image"] == null ? null : json["image"],
    products: json["products"] == null ? null : List<ProductInvoice>.from(json["products"].map((x) => ProductInvoice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "supplier_id": supplierId == null ? null : supplierId,
    "amount": amount == null ? null : amount,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "agent_id": agentId == null ? null : agentId,
    "invoices_group_id": invoicesGroupId == null ? null : invoicesGroupId,
    "image": image == null ? null : image,
    "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class ProductInvoice {
  ProductInvoice({
    this.id,
    this.invoiceId,
    this.productId,
    this.name,
    this.price,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.reviewed,
    this.image,
  });

  String id;
  String invoiceId;
  String productId;
  String name;
  int price;
  int quantity;
  DateTime createdAt;
  DateTime updatedAt;
  bool reviewed;
  String image;

  factory ProductInvoice.fromJson(Map<String, dynamic> json) => ProductInvoice(
    id: json["id"] == null ? null : json["id"],
    invoiceId: json["invoice_id"] == null ? null : json["invoice_id"],
    productId: json["product_id"] == null ? null : json["product_id"],
    name: json["name"] == null ? null : json["name"],
    price: json["price"] == null ? null : json["price"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    reviewed: json["reviewed"] == null ? null : json["reviewed"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "invoice_id": invoiceId == null ? null : invoiceId,
    "product_id": productId == null ? null : productId,
    "name": name == null ? null : name,
    "price": price == null ? null : price,
    "quantity": quantity == null ? null : quantity,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "image": image == null ? null : image,
  };
}