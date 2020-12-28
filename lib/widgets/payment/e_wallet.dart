import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_invoice_pay.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:padimall_app/utils/url_launcher.dart';

class EWalletPaymentWidget extends StatelessWidget {
  InvoicePayment invoicePayment;

  EWalletPaymentWidget({this.invoicePayment});

  String buttonText = '';

  @override
  Widget build(BuildContext context) {
    switch (invoicePayment.ewallet.ewalletType) {
      case 'OVO':
        buttonText = null;
        break;
      case 'DANA':
        buttonText = 'Lanjut ke DANA';
        break;
      case 'LINKAJA':
        buttonText = 'Lanjut ke LINKAJA';
        break;
    }

    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              if (invoicePayment.ewallet.ewalletType == 'OVO')
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
                                text: 'Perhatikan notifikasi OVO anda. Atau silahkan buka aplikasi OVO anda untuk menyelesaikan pembayaran.',
                                style: PadiMallTextTheme.sz13weight500(context),
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
                  ],
                ),
              ),
            ],
          ),
        ),
        if (buttonText != null)
          Container(
            decoration:
                BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 1, spreadRadius: 1, offset: Offset(0, 0))]),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: RaisedButton(
              onPressed: () {
                if (invoicePayment.ewallet.checkoutUrl != null) {
                  UrlLauncherServices().launchUrl(invoicePayment.ewallet.checkoutUrl);
                }
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
          )
      ],
    );
  }
}
