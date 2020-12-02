import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/providers/cart.dart';
import 'package:padimall_app/screens/checkout_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:provider/provider.dart';

class KeranjangBottomBarWidget extends StatelessWidget {
  ProviderCart _providerCart;

  @override
  Widget build(BuildContext context) {
    _providerCart = Provider.of(context, listen: false);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Total Harga',
                style: PadiMallTextTheme.sz14weight600(context),
              ),
              Text(
                'Rp ${textNumberFormatter(_providerCart.approximatePrice.toDouble())}',
                style: PadiMallTextTheme.sz14weight600Red(context),
              ),
            ],
          ),
          RaisedButton(
            onPressed: _providerCart.totalQuantityItemChecked < 1
                ? null
                : () {
                    _providerCart.getCheckoutInformation(context);
                    Navigator.pushNamed(context, CheckoutScreen.routeName);
                    // Fluttertoast.showToast(msg: "Still Development (Checkout)", backgroundColor: Theme.of(context).accentColor);
                  },
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
            child: Text(
              'Beli (${textNumberFormatter(_providerCart.totalQuantityItemChecked.toDouble())})',
              style: PadiMallTextTheme.sz14weight700White(context),
            ),
          ),
        ],
      ),
    );
  }
}
