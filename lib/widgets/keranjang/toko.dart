import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_user_cart.dart';
import 'package:padimall_app/providers/cart.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/keranjang/produk.dart';
import 'package:provider/provider.dart';

class KeranjangTokoWidget extends StatelessWidget {
  Cart cart;

  KeranjangTokoWidget({this.cart});
  
  ProviderCart _providerCart;

  @override
  Widget build(BuildContext context) {
    _providerCart = Provider.of(context, listen: false);
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 16),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                  value: cart.isSelected == null ? false : cart.isSelected,
                  onChanged: (value) {
                    _providerCart.updateSelectedCartGroupedByAgent(cart.agent.id, value);
                  },
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${cart.agent.name}',
                        style: PadiMallTextTheme.sz13weight600(context),
                      ),
                      if (cart.agent.address != null)
                        Text(
                          '${cart.agent.address}',
                          style: PadiMallTextTheme.sz10weight500Grey(context),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            ListView.builder(
              itemCount: cart.orders.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                var order = cart.orders[index];

                return KeranjangProdukWidget(
                  order: order,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
