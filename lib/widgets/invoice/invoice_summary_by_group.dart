import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_user_invoice_list.dart';
import 'package:padimall_app/screens/detail_pembelian.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:intl/intl.dart';
import 'package:padimall_app/utils/invoice_status_message.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:padimall_app/widgets/invoice/invoice_summary_each_toko.dart';

class InvoiceSummaryByGroupWidget extends StatelessWidget {
  InvoiceGroup invoiceGroup;

  InvoiceSummaryByGroupWidget({this.invoiceGroup});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'INV-${invoiceGroup.id.substring(0, 12).toUpperCase()}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${DateFormat("dd MMM yyy").format(invoiceGroup.createdAt)}',
                        // '09 Sep 2020',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                ),
                InvoiceSummaryEachToko(
                  listInvoiceSummary: invoiceGroup.invoices,
                ),
                Divider(
                  height: 0,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Total Pesanan: ',
                          style: PadiMallTextTheme.sz12weight600Soft(context),
                        ),
                        Text(
                          'Rp${textNumberFormatter(invoiceGroup.amount.toDouble())}',
                          style: PadiMallTextTheme.sz12weight600Red(context),
                        ),
                      ],
                    )),
                Container(
                  color: Theme.of(context).accentColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '${getInvoiceStatusMessage(context, invoiceGroup.status)}',
                      textAlign: TextAlign.center,
                      style: PadiMallTextTheme.sz11weight700White(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
