import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/checkout/pengiriman.dart';
import 'package:padimall_app/widgets/checkout/produk.dart';

class CheckoutTokoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Toko Subur Selalu',
            style: PadiMallTextTheme.sz13weight600(context),
          ),
          Text(
            'Medan, Sumatera utara',
            style: PadiMallTextTheme.sz10weight500Grey(context),
          ),
          ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return CheckoutProdukWidget();
            },
          ),
          Divider(),
          CheckoutPengirimanWidget(),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Subtotal',
                style: PadiMallTextTheme.sz11weight600(context),
              ),
              Text(
                'Rp2.000.000',
                style: PadiMallTextTheme.sz12weight600Red(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
