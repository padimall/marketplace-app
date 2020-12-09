import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/models/post_show_invoice_detail.dart';
import 'package:padimall_app/models/post_show_invoice_group_detail.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class InvoiceActionSection extends StatelessWidget {
  InvoiceDetail invoiceDetail;
  InvoiceGroupDetail invoiceGroupDetail;

  InvoiceActionSection({this.invoiceDetail, this.invoiceGroupDetail});

  @override
  Widget build(BuildContext context) {
    var buttonText;
    String checkStatus;

    if (invoiceGroupDetail != null) {
      checkStatus = invoiceGroupDetail.status.toString();
    } else {
      checkStatus = invoiceDetail.status;
    }

    switch (checkStatus) {
      case "0":
        buttonText = 'Bayar Sekarang';
        break;
      case "3":
        buttonText = 'Berikan Ulasan';
        break;
    }

    return buttonText == null
        ? Container()
        : Container(
            decoration:
                BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 1, spreadRadius: 1, offset: Offset(0, 0))]),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: RaisedButton(
              onPressed: () {
                Fluttertoast.showToast(msg: "Still Development ", backgroundColor: Theme.of(context).accentColor);
              },
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
