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
    this.externalId,
    this.invoiceUrl,
    this.status,
    this.bankCode,
    this.expiryDate,
    this.bankAccountNumber,
    this.transferAmount,
    this.bankBranch,
  });

  String externalId;
  String invoiceUrl;
  String status;
  String bankCode;
  DateTime expiryDate;
  String bankAccountNumber;
  int transferAmount;
  String bankBranch;

  factory InvoicePayment.fromJson(Map<String, dynamic> json) => InvoicePayment(
    externalId: json["external_id"] == null ? null : json["external_id"],
    invoiceUrl: json["invoice_url"] == null ? null : json["invoice_url"],
    status: json["status"] == null ? null : json["status"],
    bankCode: json["bank_code"] == null ? null : json["bank_code"],
    expiryDate: json["expiry_date"] == null ? null : DateTime.parse(json["expiry_date"]),
    bankAccountNumber: json["bank_account_number"] == null ? null : json["bank_account_number"],
    transferAmount: json["transfer_amount"] == null ? null : json["transfer_amount"],
    bankBranch: json["bank_branch"] == null ? null : json["bank_branch"],
  );

  Map<String, dynamic> toJson() => {
    "external_id": externalId == null ? null : externalId,
    "invoice_url": invoiceUrl == null ? null : invoiceUrl,
    "status": status == null ? null : status,
    "bank_code": bankCode == null ? null : bankCode,
    "expiry_date": expiryDate == null ? null : expiryDate.toIso8601String(),
    "bank_account_number": bankAccountNumber == null ? null : bankAccountNumber,
    "transfer_amount": transferAmount == null ? null : transferAmount,
    "bank_branch": bankBranch == null ? null : bankBranch,
  };
}