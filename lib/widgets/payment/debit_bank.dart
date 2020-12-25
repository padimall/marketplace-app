import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:intl/intl.dart';

class DebitBankPaymentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Debit Widget
    return Column(
      children: [
        // Container(
        //   color: Colors.yellow[100],
        //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        //   margin: const EdgeInsets.only(bottom: 8),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Container(
        //         margin: const EdgeInsets.only(right: 12),
        //         child: Icon(
        //           Icons.report_outlined,
        //         ),
        //       ),
        //       Expanded(
        //         child: RichText(
        //           textAlign: TextAlign.start,
        //           text: TextSpan(
        //             children: [
        //               TextSpan(
        //                 text: 'Mohon selesaikan pembayaran sebelum ',
        //                 style: PadiMallTextTheme.sz13weight500(context),
        //               ),
        //               TextSpan(
        //                 text: '${DateFormat("dd-MM-yyyy, HH:mm").format(_invoicePayment.expiryDate)}',
        //                 style: PadiMallTextTheme.sz13weight600(context),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // Container(
        //   color: Colors.white,
        //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        //   margin: const EdgeInsets.only(bottom: 8),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         'Total Pembayaran',
        //         style: PadiMallTextTheme.sz13weight500(context),
        //       ),
        //       Text(
        //         'Rp${textNumberFormatter(_invoicePayment.transferAmount.toDouble())}',
        //         style: PadiMallTextTheme.sz14weight600Red(context),
        //       ),
        //     ],
        //   ),
        // ),
        // Container(
        //   color: Colors.white,
        //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        //   margin: const EdgeInsets.only(bottom: 8),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //         margin: const EdgeInsets.only(bottom: 12),
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Text(
        //               '${_invoicePayment.bankCode}',
        //               style: PadiMallTextTheme.sz14weight500(context),
        //             ),
        //             if (_isAutoChecking)
        //               Container(
        //                 margin: const EdgeInsets.only(left: 8),
        //                 decoration: BoxDecoration(
        //                   color: Theme.of(context).primaryColor,
        //                   borderRadius: BorderRadius.circular(4),
        //                 ),
        //                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        //                 child: Text(
        //                   'Dicek Otomatis',
        //                   style: PadiMallTextTheme.sz11weight700White(context),
        //                 ),
        //               )
        //           ],
        //         ),
        //       ),
        //       Container(
        //         margin: const EdgeInsets.only(bottom: 2),
        //         child: Text(
        //           'No. Rekening',
        //           style: PadiMallTextTheme.sz13weight500(context),
        //         ),
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text(
        //             '${_invoicePayment.bankAccountNumber}',
        //             style: PadiMallTextTheme.sz14weight600(context),
        //           ),
        //           GestureDetector(
        //             onTap: () {
        //               FlutterClipboard.copy(_invoicePayment.bankAccountNumber).then((value) => Fluttertoast.showToast(
        //                   msg: 'Nomor Rekening berhasil di salin', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor));
        //             },
        //             child: Text(
        //               'SALIN',
        //               style: PadiMallTextTheme.sz14weight500Grey(context),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
