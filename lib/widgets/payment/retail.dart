import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/models/post_show_invoice_pay.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:padimall_app/utils/url_launcher.dart';
import 'package:intl/intl.dart';

class RetailPaymentWidget extends StatelessWidget {
  InvoicePayment invoicePayment;

  RetailPaymentWidget({this.invoicePayment});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                color: Colors.yellow[100],
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: Icon(
                        Icons.report_outlined,
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Mohon selesaikan pembayaran sebelum ',
                              style: PadiMallTextTheme.sz13weight500(context),
                            ),
                            TextSpan(
                              text: '${DateFormat("dd-MM-yyyy, HH:mm").format(invoicePayment.retail.expiryDate)}',
                              style: PadiMallTextTheme.sz13weight600(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Pembayaran',
                      style: PadiMallTextTheme.sz13weight500(context),
                    ),
                    Text(
                      'Rp${textNumberFormatter(invoicePayment.transferAmount.toDouble())}',
                      style: PadiMallTextTheme.sz14weight600Red(context),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${invoicePayment.retail.retailOutletName}',
                          style: PadiMallTextTheme.sz14weight500(context),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          child: Text(
                            'Bayar di outlet',
                            style: PadiMallTextTheme.sz11weight700White(context),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 2),
                      child: Text(
                        'Kode Pembayaran',
                        style: PadiMallTextTheme.sz13weight500(context),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${invoicePayment.retail.paymentCode}',
                          style: PadiMallTextTheme.sz14weight600(context),
                        ),
                        GestureDetector(
                          onTap: () {
                            FlutterClipboard.copy(invoicePayment.retail.paymentCode).then((value) => Fluttertoast.showToast(
                                msg: 'Kode pembayaran berhasil di salin', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor));
                          },
                          child: Text(
                            'SALIN',
                            style: PadiMallTextTheme.sz14weight500Grey(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
