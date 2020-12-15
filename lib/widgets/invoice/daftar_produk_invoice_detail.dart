import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_invoice_detail.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:padimall_app/widgets/invoice/produk.dart';

class DaftarProdukInvoiceDetail extends StatelessWidget {
  InvoiceDetail invoice;

  DaftarProdukInvoiceDetail({this.invoice});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    invoice.image == null
                        ? CircleAvatar(
                            backgroundImage: AssetImage('assets/images/no_image.png'),
                            radius: 15,
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage('${invoice.image}'),
                            radius: 15,
                          ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: Text(
                          '${invoice.agentName == null ? '' : invoice.agentName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: PadiMallTextTheme.sz11weight500(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: Text(
                  'Rp${textNumberFormatter(invoice.amount.toDouble())}',
                  style: PadiMallTextTheme.sz12weight600Red(context),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          itemCount: invoice.products.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            var product = invoice.products[index];

            return InvoiceProdukWidget(productInvoice: product);
          },
        ),
      ],
    );
  }
}
