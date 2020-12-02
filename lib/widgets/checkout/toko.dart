import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_checkout_info.dart';
import 'package:padimall_app/models/post_show_user_cart.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:padimall_app/widgets/checkout/pengiriman.dart';
import 'package:padimall_app/widgets/checkout/produk.dart';

class CheckoutTokoWidget extends StatelessWidget {
  CheckoutPerAgent checkoutPerAgent;

  CheckoutTokoWidget({this.checkoutPerAgent});

  @override
  Widget build(BuildContext context) {
    int _subtotal = 0;

    checkoutPerAgent.orders.forEach((order) {
      _subtotal += order.price * order.quantity;
    });

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${checkoutPerAgent.agent.name}',
            style: PadiMallTextTheme.sz13weight600(context),
          ),
          Text(
            '${checkoutPerAgent.agent.address == null ? '' : checkoutPerAgent.agent.address}',
            style: PadiMallTextTheme.sz10weight500Grey(context),
          ),
          ListView.builder(
            itemCount: checkoutPerAgent.orders.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              var order = checkoutPerAgent.orders[index];

              return CheckoutProdukWidget(
                order: order,
              );
            },
          ),
          Divider(),
          CheckoutPengirimanWidget(
            checkoutPerAgent: checkoutPerAgent,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Subtotal',
                style: PadiMallTextTheme.sz11weight600(context),
              ),
              Text(
                'Rp${textNumberFormatter(_subtotal.toDouble())}',
                style: PadiMallTextTheme.sz12weight600Red(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
