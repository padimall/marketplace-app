import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_invoice_pay.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';

class EWalletPaymentWidget extends StatelessWidget {
  InvoicePayment invoicePayment;

  EWalletPaymentWidget({this.invoicePayment});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        text: 'Mohon selesaikan pembayaran anda dalam waktu ',
                        style: PadiMallTextTheme.sz13weight500(context),
                      ),
                      TextSpan(
                        text: '${invoicePayment.ewallet.transactionDate}',
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
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${invoicePayment.ewallet.ewalletType}',
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
                        'Dicek Otomatis',
                        style: PadiMallTextTheme.sz11weight700White(context),
                      ),
                    )
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
