import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_user_invoice_list.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';

class InvoiceSummaryEachToko extends StatelessWidget {
  List<InvoiceSummary> listInvoiceSummary;

  InvoiceSummaryEachToko({this.listInvoiceSummary});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listInvoiceSummary.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, index) {
        var invoice = listInvoiceSummary[index];

        double padBottom = 0.0, padTop = 16.0;
        if (index == listInvoiceSummary.length - 1) {
          padBottom = 16.0;
          padTop = 0.0;
        }

        return Padding(
          padding: EdgeInsets.fromLTRB(16, padTop, 16, padBottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Text(
                  '${invoice.agentName}',
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
                      child: invoice.image == null
                          ? Image.asset(
                              'assets/images/no_image.png',
                              height: 65,
                              width: 65,
                              fit: BoxFit.cover,
                            )
                          : FadeInImage.assetNetwork(
                              image: '${invoice.image}',
                              placeholder: 'assets/images/placeholder.png',
                              height: 65,
                              width: 65,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  if (invoice.products.isNotEmpty)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${invoice.products[0].name}',
                            overflow: TextOverflow.ellipsis,
                            style: PadiMallTextTheme.sz13weight600(context),
                          ),
                          Text(
                            'Jumlah: ${textNumberFormatter(invoice.products[0].quantity.toDouble())}',
                            overflow: TextOverflow.ellipsis,
                            style: PadiMallTextTheme.sz11weight500Grey(context),
                          ),
                        ],
                      ),
                    )
                ],
              ),
              if (index < listInvoiceSummary.length - 1)
                Divider(
                  height: 25,
                  color: Colors.grey[400],
                )
            ],
          ),
        );
      },
    );
  }
}
