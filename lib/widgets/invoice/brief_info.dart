import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_invoice_detail.dart';
import 'package:padimall_app/models/post_show_invoice_group_detail.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:intl/intl.dart';
import 'package:padimall_app/utils/invoice_status_message.dart';

class InvoiceBriefInfo extends StatelessWidget {
  InvoiceDetail invoiceDetail;
  InvoiceGroupDetail invoiceGroupDetail;

  InvoiceBriefInfo({this.invoiceDetail, this.invoiceGroupDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    'Nomor Invoice',
                    style: PadiMallTextTheme.sz11weight500(context),
                  ),
                ),
                invoiceGroupDetail != null
                    ? Text(
                        'INV-${invoiceGroupDetail.id.substring(0, 12).toUpperCase()}',
                        style: PadiMallTextTheme.sz12weight600Soft(context),
                      )
                    : Text(
                        'INV-${invoiceDetail.id.substring(0, 12).toUpperCase()}',
                        style: PadiMallTextTheme.sz12weight600Soft(context),
                      ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    'Tanggal Pembelian',
                    style: PadiMallTextTheme.sz11weight500(context),
                  ),
                ),
                invoiceGroupDetail != null
                    ? Text(
                        '${DateFormat("dd MMM yyy, HH:mm").format(invoiceGroupDetail.createdAt)}',
                        style: PadiMallTextTheme.sz12weight600Soft(context),
                      )
                    : Text(
                        '${DateFormat("dd MMM yyy, HH:mm").format(invoiceDetail.createdAt)}',
                        style: PadiMallTextTheme.sz12weight600Soft(context),
                      ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    'Status',
                    style: PadiMallTextTheme.sz11weight500(context),
                  ),
                ),
                invoiceGroupDetail != null
                    ? Text(
                        '${getInvoiceStatusMessage(context, invoiceGroupDetail.status, 'buyer')}',
                        style: PadiMallTextTheme.sz12weight600Green(context),
                      )
                    : Text(
                        '${getInvoiceStatusMessage(context, int.parse(invoiceDetail.status), 'buyer')}',
                        style: PadiMallTextTheme.sz12weight600Green(context),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
