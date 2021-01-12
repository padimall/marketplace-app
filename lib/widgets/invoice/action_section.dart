import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_invoice_detail.dart';
import 'package:padimall_app/models/post_show_invoice_group_detail.dart';
import 'package:padimall_app/models/post_show_invoice_pay.dart';
import 'package:padimall_app/providers/histories.dart';
import 'package:padimall_app/screens/invoice_payment_screen.dart';
import 'package:padimall_app/screens/review_product_screen.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/alert_dialog/input_resi.dart';
import 'package:provider/provider.dart';

class InvoiceActionSection extends StatelessWidget {
  String checkStatus;
  Function buttonHandler;

  ProviderHistories providerHistories;

  InvoiceDetail invoiceDetail;
  InvoiceGroupDetail invoiceGroupDetail;
  InvoicePayment invoicePayment;
  bool isBuyer;

  InvoiceActionSection({this.invoiceDetail, this.invoiceGroupDetail, this.invoicePayment, this.isBuyer});

  @override
  Widget build(BuildContext context) {
    providerHistories = Provider.of(context, listen: false);
    var buttonText;

    if (invoiceGroupDetail != null) {
      checkStatus = invoiceGroupDetail.status.toString();
    } else {
      checkStatus = invoiceDetail.status;
    }

    if (isBuyer) {
      // For Buyer
      switch (checkStatus) {
        case "0":
          buttonText = 'Bayar Sekarang';
          buttonHandler = () {
            Navigator.pushNamed(context, InvoicePaymentScreen.routeName, arguments: invoiceGroupDetail.id);
          };
          break;
        case "2":
          buttonText = 'Selesaikan Pesanan';
          buttonHandler = () {
            CustomAlertDialog.dialogOfTwo(context, true, 'Perhatian',
                'Pesanan yang telah diselesaikan tidak dapat diadukan lagi kemudian hari. Selesaikan pesanan?', 'Ya, selesaikan', 'Belum', () {
              Navigator.pop(context);
              providerHistories.invoiceReceived(context, invoiceDetail.id);
            }, () {
              Navigator.pop(context);
            });
          };
          break;
        case "3":
          var reviewedInvoiceProductList = invoiceDetail.products.where((element) => element.reviewed).toList();
          if (reviewedInvoiceProductList.length != invoiceDetail.products.length) {
            buttonText = 'Berikan Ulasan';
            buttonHandler = () {
              Navigator.pushNamed(context, ReviewProductScreen.routeName, arguments: {'invoice_id': invoiceDetail.id, 'products': invoiceDetail.products});
            };
          }
          break;
        default:
          buttonText = null;
          break;
      }
    } else {
      // For Seller
      switch (checkStatus) {
        case "1":
          buttonText = 'Masukkan Nomor Resi';
          buttonHandler = () {
            showAlertDialogInputResi(context, invoiceDetail.id);
          };
          break;
        default:
          buttonText = null;
          break;
      }
    }

    return buttonText == null
        ? Container()
        : Container(
            decoration:
                BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 1, spreadRadius: 1, offset: Offset(0, 0))]),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: RaisedButton(
              onPressed: buttonHandler,
              child: Text(
                '$buttonText',
                style: PadiMallTextTheme.sz16weight700White(context),
              ),
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
          );
  }
}
