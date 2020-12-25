class PostResInvoicePay {
  PostResInvoicePay({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  InvoicePayment data;

  factory PostResInvoicePay.fromJson(Map<String, dynamic> json) => PostResInvoicePay(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : InvoicePayment.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
}

class InvoicePayment {
  InvoicePayment({
    this.status,
    this.transferAmount,
    this.ewallet,
  });

  String status;
  int transferAmount;
  Ewallet ewallet;

  factory InvoicePayment.fromJson(Map<String, dynamic> json) => InvoicePayment(
    status: json["status"] == null ? null : json["status"],
    transferAmount: json["transfer_amount"] == null ? null : json["transfer_amount"],
    ewallet: json["ewallet"] == null ? null : Ewallet.fromJson(json["ewallet"]),
  );

  Map<String, dynamic> toJson() => {
    "ewallet": ewallet == null ? null : ewallet.toJson(),
    "status": status == null ? null : status,
    "transfer_amount": transferAmount == null ? null : transferAmount,
  };
}

class Ewallet {
  Ewallet({
    this.ewalletType,
    this.checkoutUrl,
    this.expiryDate,
    this.transactionDate,
  });

  String ewalletType;
  dynamic checkoutUrl;
  DateTime expiryDate;
  DateTime transactionDate;

  factory Ewallet.fromJson(Map<String, dynamic> json) => Ewallet(
    ewalletType: json["ewallet_type"] == null ? null : json["ewallet_type"],
    checkoutUrl: json["checkout_url"] == null ? null : json["checkout_url"],
    expiryDate: json["expiry_date"] == null ? null : DateTime.parse(json["expiry_date"]),
    transactionDate: json["transaction_date"] == null ? null : DateTime.parse(json["transaction_date"]),
  );

  Map<String, dynamic> toJson() => {
    "ewallet_type": ewalletType == null ? null : ewalletType,
    "checkout_url": checkoutUrl,
    "transaction_date": transactionDate == null ? null : transactionDate.toIso8601String(),
  };
}