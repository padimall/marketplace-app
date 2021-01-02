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
    this.debitBank,
    this.retail,
    this.expiryDate,
  });

  String status;
  int transferAmount;
  Ewallet ewallet;
  DebitBank debitBank;
  Retail retail;
  DateTime expiryDate;

  factory InvoicePayment.fromJson(Map<String, dynamic> json) => InvoicePayment(
    status: json["status"] == null ? null : json["status"],
    transferAmount: json["transfer_amount"] == null ? null : json["transfer_amount"],
    ewallet: json["ewallet"] == null ? null : Ewallet.fromJson(json["ewallet"]),
    debitBank: json["debit_bank"] == null ? null : DebitBank.fromJson(json["debit_bank"]),
    retail: json["retail"] == null ? null : Retail.fromJson(json["retail"]),
    expiryDate: json["expiry_date"] == null ? null : DateTime.parse(json["expiry_date"]),
  );

  Map<String, dynamic> toJson() => {
    "ewallet": ewallet == null ? null : ewallet.toJson(),
    "status": status == null ? null : status,
    "transfer_amount": transferAmount == null ? null : transferAmount,
  };
}

class DebitBank {
  DebitBank({
    this.invoiceUrl,
    this.bankCode,
    this.bankAccountNumber,
    this.bankBranch,
  });

  String invoiceUrl;
  String bankCode;
  String bankAccountNumber;
  String bankBranch;

  factory DebitBank.fromJson(Map<String, dynamic> json) => DebitBank(
    invoiceUrl: json["invoice_url"] == null ? null : json["invoice_url"],
    bankCode: json["bank_code"] == null ? null : json["bank_code"],
    bankAccountNumber: json["bank_account_number"] == null ? null : json["bank_account_number"],
    bankBranch: json["bank_branch"] == null ? null : json["bank_branch"],
  );

  Map<String, dynamic> toJson() => {
    "invoice_url": invoiceUrl == null ? null : invoiceUrl,
    "bank_code": bankCode == null ? null : bankCode,
    "bank_account_number": bankAccountNumber == null ? null : bankAccountNumber,
    "bank_branch": bankBranch == null ? null : bankBranch,
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

class Retail {
  Retail({
    this.retailOutletName,
    this.expiryDate,
    this.paymentCode,
  });

  String retailOutletName;
  DateTime expiryDate;
  String paymentCode;

  factory Retail.fromJson(Map<String, dynamic> json) => Retail(
    retailOutletName: json["retail_outlet_name"] == null ? null : json["retail_outlet_name"],
    expiryDate: json["expiry_date"] == null ? null : DateTime.parse(json["expiry_date"]),
    paymentCode: json["payment_code"] == null ? null : json["payment_code"],
  );

  Map<String, dynamic> toJson() => {
    "retail_outlet_name": retailOutletName == null ? null : retailOutletName,
    "expiry_date": expiryDate == null ? null : expiryDate.toIso8601String(),
    "payment_code": paymentCode == null ? null : paymentCode,
  };
}