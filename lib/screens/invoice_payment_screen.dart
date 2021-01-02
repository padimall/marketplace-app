import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/models/post_show_invoice_pay.dart';
import 'package:padimall_app/providers/histories.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:padimall_app/widgets/payment/debit_bank.dart';
import 'package:padimall_app/widgets/payment/e_wallet.dart';
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
            InvoicePayment _invoicePayment = _providerHistories.invoicePayment;

            // If invoice payment using e-wallet
            if (_invoicePayment.ewallet != null)
              return EWalletPaymentWidget(
                invoicePayment: _invoicePayment,
              );
            else if (_invoicePayment.debitBank != null)
              return DebitBankPaymentWidget(
                invoicePayment: _invoicePayment,
              );

            // Default return
            return Container();
          },
        ),
      ),
    );
  }
}
