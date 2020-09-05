import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/screens/checkout_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class KeranjangBottomBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                'Rp2.000.000',
                style: PadiMallTextTheme.sz14weight600Red(context),
              ),
            ],
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, CheckoutScreen.routeName);
            },
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
            child: Text(
              'Beli (100)',
              style: PadiMallTextTheme.sz14weight700White(context),
            ),
          ),
        ],
      ),
    );
  }
}
