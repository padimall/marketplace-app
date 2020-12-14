import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/providers/histories.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class InvoicePaymentScreen extends StatelessWidget {
  static final routeName = 'invoice-payment-screen';

  ProviderHistories _providerHistories;

  @override
  Widget build(BuildContext context) {
    _providerHistories = Provider.of(context, listen: false);

    final String invoiceGroupId = ModalRoute.of(context).settings.arguments;

    print('id $invoiceGroupId');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pembayaran Anda',
          style: PadiMallTextTheme.sz16weight700(context),
        ),
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 15,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: buildFutureBuilder(
        _providerHistories.getInvoicePaymentDetail(context, invoiceGroupId),
        Consumer<ProviderHistories>(
          builder: (ctx, provider, _) {
            var _invoicePayment = _providerHistories.invoicePayment;
            bool _isAutoChecking = false;

            switch (_invoicePayment.bankBranch) {
              case "Virtual Account":
                _isAutoChecking = true;
                break;
            }

            return Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Mohon selesaikan pembayaran sebelum ',
                                style: PadiMallTextTheme.sz14weight500(context),
                              ),
                              TextSpan(
                                text: '${DateFormat("dd-MM-yy, HH:mm").format(_invoicePayment.expiryDate)}',
                                style: PadiMallTextTheme.sz14weight600(context),
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
                        'Rp${textNumberFormatter(_invoicePayment.transferAmount.toDouble())}',
                        style: PadiMallTextTheme.sz14weight600Red(context),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${_invoicePayment.bankCode}',
                              style: PadiMallTextTheme.sz14weight500(context),
                            ),
                            if (_isAutoChecking)
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
                      Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          'No. Rekening',
                          style: PadiMallTextTheme.sz13weight500(context),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_invoicePayment.bankAccountNumber}',
                            style: PadiMallTextTheme.sz14weight600(context),
                          ),
                          GestureDetector(
                            onTap: () {
                              FlutterClipboard.copy(_invoicePayment.bankAccountNumber).then((value) => Fluttertoast.showToast(
                                  msg: 'Nomor Rekening berhasil di salin', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor));
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
            );
          },
        ),
      ),
    );
  }
}
