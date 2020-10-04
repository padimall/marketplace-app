import 'package:flutter/material.dart';
import 'package:padimall_app/screens/regis_supplier_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class NoTokoYetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/business.png',
            height: 200,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Ayo daftarkan dirimu sebagai Supplier',
              style: PadiMallTextTheme.sz13weight600Soft(context),
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, RegisterSupplierScreen.routeName);
            },
            child: Text(
              'Jadi Supplier',
              style: PadiMallTextTheme.sz14weight700White(context),
            ),
            color: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          )
        ],
      ),
    );
  }
}
