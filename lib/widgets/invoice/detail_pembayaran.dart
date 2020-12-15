import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_invoice_detail.dart';
import 'package:padimall_app/models/post_show_invoice_group_detail.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';

class InvoiceDetailPembayaran extends StatelessWidget {
  InvoiceDetail invoiceDetail;
  InvoiceGroupDetail invoiceGroupDetail;

  InvoiceDetailPembayaran({this.invoiceDetail, this.invoiceGroupDetail});

  @override
  Widget build(BuildContext context) {
    String paymentMethod;
    int amountGrandTotal;

    if (invoiceGroupDetail != null) {
      paymentMethod = invoiceGroupDetail.payment.methodCode;
      amountGrandTotal = invoiceGroupDetail.amount;
    } else {
      paymentMethod = invoiceDetail.payment.methodCode;
      amountGrandTotal = invoiceDetail.amount;
    }

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Detail Pembayaran',
              style: PadiMallTextTheme.sz13weight600Soft(context),
            ),
          ),
          _buildPembayaranRow(context, 'Metode Pembayaran', '${paymentMethod}'),
          // if (invoiceDetail != null) _buildPembayaranRow(context, 'Harga barang', 'Rp${textNumberFormatter(amountGrandTotal.toDouble())}'),
          // _buildPembayaranRow(context, 'Ongkos Kirim', 'Rp100.000'),
          Container(
            margin: const EdgeInsets.only(top: 2, bottom: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total Bayar',
                  style: PadiMallTextTheme.sz12weight600Soft(context),
                ),
                Text(
                  'Rp${textNumberFormatter(amountGrandTotal.toDouble())}',
                  style: PadiMallTextTheme.sz12weight600Red(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPembayaranRow(BuildContext context, String leftText, String rightText) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$leftText',
            style: PadiMallTextTheme.sz12weight500(context),
          ),
          Text(
            '$rightText',
            style: PadiMallTextTheme.sz12weight600Soft(context),
          ),
        ],
      ),
    );
  }
}
