import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_user_invoice_list.dart';
import 'package:padimall_app/screens/detail_pembelian.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:intl/intl.dart';
import 'package:padimall_app/utils/invoice_status_message.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:padimall_app/widgets/invoice/invoice_summary_each_toko.dart';

class InvoiceSummaryByInvoiceWidget extends StatelessWidget {
  InvoiceSummary invoiceSummary;

  InvoiceSummaryByInvoiceWidget({this.invoiceSummary});

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
                        'INV-${invoiceSummary.id.substring(0, 12).toUpperCase()}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${DateFormat("dd MMM yyy, HH:mm").format(invoiceSummary.createdAt)}',
                        // '09 Sep 2020',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (invoiceSummary.agentName != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            '${invoiceSummary.agentName}',
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: PadiMallTextTheme.sz11weight500(context),
                          ),
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: invoiceSummary.image == null
                                  ? Image.asset(
                                      'assets/images/no_image.png',
                                      height: 65,
                                      width: 65,
                                      fit: BoxFit.cover,
                                    )
                                  : FadeInImage.assetNetwork(
                                      image: '${invoiceSummary.image}',
                                      placeholder: 'assets/images/placeholder.png',
                                      height: 65,
                                      width: 65,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          if (invoiceSummary.products.isNotEmpty)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${invoiceSummary.products[0].name}',
                                    overflow: TextOverflow.ellipsis,
                                    style: PadiMallTextTheme.sz13weight600(context),
                                  ),
                                  Text(
                                    'Jumlah: ${textNumberFormatter(invoiceSummary.products[0].quantity.toDouble())}',
                                    overflow: TextOverflow.ellipsis,
                                    style: PadiMallTextTheme.sz11weight500Grey(context),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
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
                          'Rp${textNumberFormatter(invoiceSummary.amount.toDouble())}',
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
                      '${getInvoiceStatusMessage(context, int.parse(invoiceSummary.status))}',
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
