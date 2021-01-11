import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_user_invoice_list.dart';
import 'package:padimall_app/screens/product_detail_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';

class InvoiceProdukWidget extends StatelessWidget {
  ProductInvoice productInvoice;

  InvoiceProdukWidget({this.productInvoice});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: {'product_name': productInvoice.name, 'product_id': productInvoice.id});
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: productInvoice.image == null
                    ? Image.asset(
                        'assets/images/no_image.png',
                        height: 75,
                        width: 75,
                        fit: BoxFit.cover,
                      )
                    : FadeInImage.assetNetwork(
                        image: '${productInvoice.image}',
                        fit: BoxFit.cover,
                        height: 75,
                        width: 75,
                        placeholder: 'assets/images/logo.png',
                      ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          child: Text(
                            '${productInvoice.name}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: PadiMallTextTheme.sz12weight600(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      'Jumlah: ${textNumberFormatter(productInvoice.quantity.toDouble())}',
                      style: PadiMallTextTheme.sz11weight500Grey(context),
                    ),
                  ),
                  Text(
                    'Rp${textNumberFormatter(productInvoice.price.toDouble())}',
                    style: PadiMallTextTheme.sz11weight500(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
