import 'package:flutter/material.dart';
import 'package:padimall_app/providers/cart.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/show_modal_bottom.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:padimall_app/widgets/checkout/alamat.dart';
import 'package:padimall_app/widgets/checkout/toko.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  static final routeName = 'checkout-screen';

  ProviderCart _providerCart;

  @override
  Widget build(BuildContext context) {
    _providerCart = Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengiriman',
          style: PadiMallTextTheme.sz16weight700(context),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 15,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: buildFutureBuilder(
        _providerCart.getCheckoutInformation(context),
        Consumer<ProviderCart>(
          builder: (ctx, provider, _) {
            var _grandTotal = 0;
            
            _providerCart.checkoutDetail.checkouts.forEach((checkoutPerAgent) { 
              checkoutPerAgent.orders.forEach((order) { 
                _grandTotal += order.quantity * order.price;
              });
            });
            
            return Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CheckoutAlamatWidget(
                          userProfileDetail: _providerCart.checkoutDetail.user,
                        ),
                        ListView.builder(
                          itemCount: _providerCart.checkoutDetail.checkouts.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            var checkoutPerAgent = _providerCart.checkoutDetail.checkouts[index];

                            return CheckoutTokoWidget(
                              checkoutPerAgent: checkoutPerAgent,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100],
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Total Harga',
                            style: PadiMallTextTheme.sz12weight600(context),
                          ),
                          Text(
                            'Rp${textNumberFormatter(_grandTotal.toDouble())}',
                            style: PadiMallTextTheme.sz14weight600Red(context),
                          ),
                        ],
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Text(
                          'Pilih Pembayaran',
                          style: PadiMallTextTheme.sz14weight700White(context),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
