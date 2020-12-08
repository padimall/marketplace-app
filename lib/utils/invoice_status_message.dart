import 'package:flutter/material.dart';

String getInvoiceStatusMessage(BuildContext context, int status, String role) {
  String _statusMessage;

  switch (status) {
    case 0:
      _statusMessage = "Menunggu Pembayaran";
      break;
    case 1:
      if (role == "seller") {
        _statusMessage = "Pesanan baru";
      } else {
        _statusMessage = "Sedang dikemas";
      }
      break;
    case 2:
      _statusMessage = "Sedang dikirim";
      break;
    case 3:
      _statusMessage = "Sudah sampai tujuan";
      break;
    case 4:
      _statusMessage = "Pesanan dibatalkan";
      break;
    default:
      _statusMessage = "N/A";
      break;
  }

  return _statusMessage;
}
