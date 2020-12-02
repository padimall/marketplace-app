import 'package:flutter/material.dart';
import 'package:padimall_app/models/order.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';

class CheckoutProdukWidget extends StatelessWidget {
  Order order;

  CheckoutProdukWidget({this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                '${order.urlPicture}',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    '${order.name}',
                    style: PadiMallTextTheme.sz12weight600(context),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    'Rp${textNumberFormatter(order.price.toDouble())}',
                    style: PadiMallTextTheme.sz12weight600Red(context),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Jumlah: ${textNumberFormatter(order.quantity.toDouble())}',
                      style: PadiMallTextTheme.sz12weight500Grey(context),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
