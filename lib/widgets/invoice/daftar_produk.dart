import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_invoice_detail.dart';
import 'package:padimall_app/models/post_show_invoice_group_detail.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:padimall_app/widgets/checkout/produk.dart';
import 'package:padimall_app/widgets/invoice/produk.dart';

import 'daftar_produk_invoice_detail.dart';

class InvoiceDaftarProduk extends StatelessWidget {
  InvoiceDetail invoiceDetail;
  InvoiceGroupDetail invoiceGroupDetail;

  InvoiceDaftarProduk({this.invoiceDetail, this.invoiceGroupDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          invoiceGroupDetail != null
              ? ListView.builder(
                  itemCount: invoiceGroupDetail.invoices.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, indexAgent) {
                    var invoice = invoiceGroupDetail.invoices[indexAgent];

                    return DaftarProdukInvoiceDetail(
                      invoice: invoice,
                    );
                  },
                )
              : DaftarProdukInvoiceDetail(
                  invoice: invoiceDetail,
                ),
        ],
      ),
    );
  }
}
